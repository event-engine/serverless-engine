import {MultiModelStore} from "@app/infrastructure/MultiModelStore";
import {DB} from "@app/infrastructure/Postgres/DB";
import {PostgresEventStore} from "@app/infrastructure/EventStore/PostgresEventStore";
import {PostgresDocumentStore} from "@app/infrastructure/DocumentStore/PostgresDocumentStore";
import {Session} from "@app/infrastructure/MultiModelStore/Session";
import {MetadataMatcher} from "@app/infrastructure/EventStore";
import {Event, EventMeta} from "@app/messaging/event";
import {QueryResult} from "pg";
import {PostgresQueryBuilder} from "@app/infrastructure/DocumentStore/Postgres/PostgresQueryBuilder";
import {PostgresFilterProcessor} from "@app/infrastructure/DocumentStore/Postgres/PostgresFilterProcessor";
import {PostgresIndexProcessor} from "@app/infrastructure/DocumentStore/Postgres/PostgresIndexProcessor";

type Query = [string, any[]];

export class PostgresMultiModelStore implements MultiModelStore {
  private db: DB;
  private eventStore: PostgresEventStore;
  private documentStore: PostgresDocumentStore;
  private queryBuilder: PostgresQueryBuilder;


  constructor(db: DB, eventStore: PostgresEventStore, documentStore: PostgresDocumentStore) {
    this.db = db;
    this.eventStore = eventStore;
    this.documentStore = documentStore;
    this.queryBuilder = new PostgresQueryBuilder(
      new PostgresFilterProcessor(),
      new PostgresIndexProcessor()
    )
  }

  beginSession(): Session {
    return new Session();
  }

  async commitSession(session: Session): Promise<boolean> {
    session.commit();


    const queries: Query[] = [];

    session.getAppendEventsTasks().forEach(task => {
      const [query, bindings] = this.eventStore.makeAppendToQuery(
        task.streamName,
        task.events
      );

      if(query) {
        queries.push([query, bindings]);
      }
    });

    session.getUpsertDocumentTasks().forEach(task => queries.push(this.queryBuilder.makeUpsertDocQuery(
      task.collectionName,
      task.docId,
      task.doc
    )));

    await this.db.transaction(function* (): Generator<Query, void, QueryResult> {
      for (const query of queries) {
        yield query;
      }
    });

    session.getAppendEventsTasks().forEach(task => {
      this.eventStore.triggerAppendToListeners(task.streamName, task.events);
    })

    return true;
  }

  loadDoc<D extends object>(collectionName: string, docId: string): Promise<D | null> {
    return this.documentStore.getDoc(collectionName, docId);
  }

  loadEvents<P, M extends EventMeta = any>(streamName: string, metadataMatcher?: MetadataMatcher, fromEventId?: string, limit?: number): Promise<AsyncIterable<Event<P, M>>> {
    return this.eventStore.load(streamName, metadataMatcher, fromEventId, limit);
  }
}
