import {DocumentStore} from "@app/infrastructure/DocumentStore";
import {PostgresDocumentStore} from "@app/infrastructure/DocumentStore/PostgresDocumentStore";
import {getConfiguredDB} from "@app/core/configuredDB";
import {env} from "@app/env";
import {InMemoryDocumentStore} from "@app/infrastructure/DocumentStore/InMemoryDocumentStore";

let store: DocumentStore;

export const PERSISTENT_COLLECTION_FILE = process.cwd() + '/../../data/persistent-collections.json';

export const getConfiguredDocumentStore = (): DocumentStore => {
  if(!store) {
    if(env.documentStore.adapter === "postgres") {
      store = new PostgresDocumentStore(getConfiguredDB());
    } else {
      store = new InMemoryDocumentStore();
    }
  }

  return store;
}
