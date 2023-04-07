import {EventStore} from "@app/infrastructure/EventStore";
import {PostgresEventStore} from "@app/infrastructure/EventStore/PostgresEventStore";
import {getConfiguredDB} from "@app/core/configuredDB";
import {env} from "@app/env";
import {InMemoryEventStore} from "@app/infrastructure/EventStore/InMemoryEventStore";
import {InMemoryStreamListenerQueue} from "@app/infrastructure/Queue/InMemoryStreamListenerQueue";
import {EventDispatcher} from "@app/infrastructure/EventDispatcher";
export const WRITE_MODEL_STREAM = 'write_model_stream';
export const PUBLIC_STREAM = 'public_stream';

export const PERSISTENT_STREAMS_FILE = process.cwd() + '/../../data/persistent-streams.json';

let es: EventStore;
let fleetManagementDispatch: EventDispatcher;
let subscriptionsDispatch: EventDispatcher;
export const getConfiguredEventStore = (): EventStore => {
  if(!es) {
    if(env.eventStore.adapter === "postgres") {
      es = new PostgresEventStore(getConfiguredDB());
    } else {
      es = new InMemoryEventStore();
    }

    // Avoid circular deps in listeners
      const streamListener = new InMemoryStreamListenerQueue(es, PUBLIC_STREAM);

    streamListener.attachConsumer(async (evt): Promise<boolean> => {
      if(!fleetManagementDispatch) {
        fleetManagementDispatch = (await import('@app/fleet-management/async/listeners')).default;
      }

      if(!subscriptionsDispatch) {
        subscriptionsDispatch = (await import('@app/subscriptions/async/listeners')).default;
      }

      const successFmt = await fleetManagementDispatch(evt);
      const successSubscriptions = await subscriptionsDispatch(evt);
      return successFmt && successSubscriptions;
    });

    streamListener.startProcessing();
  }

  return es;
}
