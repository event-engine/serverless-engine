import {MultiModelStore} from "@app/infrastructure/MultiModelStore";
import {Session} from "@app/infrastructure/MultiModelStore/Session";
import {InMemoryEventStore} from "@app/infrastructure/EventStore/InMemoryEventStore";
import {InMemoryDocumentStore} from "@app/infrastructure/DocumentStore/InMemoryDocumentStore";
import {MetadataMatcher} from "@app/infrastructure/EventStore";
import {Event, EventMeta} from "@app/messaging/event";

export class InMemoryMultiModelStore implements MultiModelStore {
  private eventStore: InMemoryEventStore;
  private documentStore: InMemoryDocumentStore;

  constructor(eventStore: InMemoryEventStore, documentStore: InMemoryDocumentStore) {
    this.eventStore = eventStore;
    this.documentStore = documentStore;
  }

  async loadEvents <P = any, M extends EventMeta = any>(streamName: string, metadataMatcher?: MetadataMatcher, fromEventId?: string, limit?: number): Promise<AsyncIterable<Event<P,M>>> {
    return this.eventStore.load(streamName, metadataMatcher, fromEventId, limit);
  }

  async loadDoc <D extends object>(collectionName: string, docId: string): Promise<D | null> {
    return this.documentStore.getDoc(collectionName, docId);
  }

  beginSession(): Session {
    return new Session();
  }

  async commitSession(session: Session): Promise<boolean> {
    session.commit();

    session.getAppendEventsTasks().forEach(task => this.eventStore.appendTo(
      task.streamName,
      task.events,
      task.metadataMatcher,
      task.expectedVersion
    ));

    session.getUpsertDocumentTasks().forEach(task => this.documentStore.upsertDoc(
      task.collectionName,
      task.docId,
      task.doc
    ));

    return true;
  }
}
