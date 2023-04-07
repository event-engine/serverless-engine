import {InMemoryEventStore} from "@app/infrastructure/EventStore/InMemoryEventStore";
import {Event} from "@app/messaging/event";
import {makeTestEvent} from "@app/infrastructure/helpers.spec";
import {LambdaBatchHandlerQueue, LambdaMessage} from "@app/infrastructure/Queue/LambdaBatchHandlerQueue";
import {randomUUID} from "crypto";
import {InMemoryDocumentStore} from "@app/infrastructure/DocumentStore/InMemoryDocumentStore";
import {
  makePersistentCatchUpSubscription,
  SUBSCRIPTIONS_COLLECTION, SubscriptionSnapshot
} from "@app/infrastructure/Subscription/makePersistentCatchUpSubscription";
import {CatchUpSubscription} from "@app/infrastructure/Subscription/CatchUpSubscription";

describe("makePersistentCatchUpSubscription", () => {
  const es = new InMemoryEventStore();
  const ds = new InMemoryDocumentStore();
  const TEST_STREAM = 'test_stream';
  const TEST_SUBSCRIPTION = 'test_subscription';

  es.createStream(TEST_STREAM);
  ds.addCollection(SUBSCRIPTIONS_COLLECTION);

  const oldEvents: Event[] = [];
  const eventIds = [randomUUID(), randomUUID(), randomUUID()];

  for(let i = 0; i < 3; i++) {
    oldEvents.push(makeTestEvent({
        uuid: eventIds[i],
        name: 'Old Event ' + (i+1),
      }
    ));
  }

  beforeAll(async () => {
    await es.appendTo(TEST_STREAM, oldEvents);
    await ds.addDoc(SUBSCRIPTIONS_COLLECTION, TEST_SUBSCRIPTION, {
      test_stream: {lastProcessedEvent: eventIds[2], metadataMatcher: undefined}
    });
  })

  const newEvents: LambdaMessage[] = [];
  const newEventIds = [randomUUID(), randomUUID(), randomUUID()];
  for(let i = 0; i < 3; i++) {
    newEvents.push({
      messageId: randomUUID(),
      event: makeTestEvent({
          uuid: newEventIds[i],
          name: 'New Event ' + (i+1),
        }
      )
    });
  }

  it("wraps catch up subscription with persistent layer", async () => {
    const processedEvents: string[] = [];

    const consumer = async (evt: Event): Promise<boolean> => {
      processedEvents.push(evt.name);
      return true;
    }

    const queue = new LambdaBatchHandlerQueue(TEST_STREAM);

    const subscription = makePersistentCatchUpSubscription(
      TEST_SUBSCRIPTION,
      [TEST_STREAM],
      consumer,
      [queue],
      es,
      ds
    );


    const queueFinished = queue.push(newEvents);
    await subscription.startProcessing();
    const failedMessages = await queueFinished;

    expect(failedMessages.length).toEqual(0);
    expect(processedEvents).toEqual([
      'New Event 1',
      'New Event 2',
      'New Event 3',
    ])

    const subscriptionSnapshot = await ds.getDoc<SubscriptionSnapshot>(SUBSCRIPTIONS_COLLECTION, TEST_SUBSCRIPTION);

    expect(subscriptionSnapshot).not.toBeNull();

    if(subscriptionSnapshot) {
      expect(subscriptionSnapshot[TEST_STREAM].lastProcessedEvent).toBe(newEventIds[2]);
    }
  })
})
