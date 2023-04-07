import {MultiModelStore} from "@app/infrastructure/MultiModelStore";
import {getConfiguredEventStore} from "@app/core/configuredEventStore";
import {getConfiguredDocumentStore} from "@app/core/configuredDocumentStore";
import {PostgresDocumentStore} from "@app/infrastructure/DocumentStore/PostgresDocumentStore";
import {getConfiguredDB} from "@app/core/configuredDB";
import {PostgresMultiModelStore} from "@app/infrastructure/MultiModelStore/PostgresMultiModelStore";
import {PostgresEventStore} from "@app/infrastructure/EventStore/PostgresEventStore";
import {env} from "@app/env";
import {InMemoryEventStore} from "@app/infrastructure/EventStore/InMemoryEventStore";
import {InMemoryDocumentStore} from "@app/infrastructure/DocumentStore/InMemoryDocumentStore";
import {InMemoryMultiModelStore} from "@app/infrastructure/MultiModelStore/InMemoryMultiModelStore";

let store: MultiModelStore;

export const getConfiguredMultiModelStore = () => {
  if(!store) {
    const es = getConfiguredEventStore();
    const ds = getConfiguredDocumentStore();

    if(env.eventStore.adapter === "postgres" && env.documentStore.adapter === "postgres") {
      if(!(es instanceof PostgresEventStore)) {
        throw new Error("Postgres MultiModelStore requires an instance of PostgresEventStore, but another EventStore is given.");
      }

      if(!(ds instanceof PostgresDocumentStore)) {
        throw new Error("Postgres MultiModelStore requires an instance of PostgresDocumentStore, but another DocumentStore is given.");
      }

      store = new PostgresMultiModelStore(
        getConfiguredDB(),
        es,
        ds
      )
    }

    if(env.eventStore.adapter === "memory" && env.documentStore.adapter === "memory") {
      if(!(es instanceof InMemoryEventStore)) {
        throw new Error("InMemory MultiModelStore requires an instance of InMemoryEventStore, but another EventStore is given.");
      }

      if(!(ds instanceof InMemoryDocumentStore)) {
        throw new Error("InMemory MultiModelStore requires an instance of InMemoryDocumentStore, but another DocumentStore is given.");
      }

      store = new InMemoryMultiModelStore(
        es,
        ds
      )
    }
  }

  return store;
}
