import { getConfiguredEventStore, PUBLIC_STREAM, WRITE_MODEL_STREAM } from "@app/core/configuredEventStore";
import { getConfiguredDocumentStore } from "@app/core/configuredDocumentStore";
import { PostgresDocumentStore } from "@app/infrastructure/DocumentStore/PostgresDocumentStore";

const eventStore = getConfiguredEventStore();
const documentStore = getConfiguredDocumentStore();

eventStore.hasStream(WRITE_MODEL_STREAM).then(hasStream => {
  if (!hasStream) {
    eventStore.createStream(WRITE_MODEL_STREAM).then(success => {
      if (success) {
        console.log(`${WRITE_MODEL_STREAM} stream created.`);
      } else {
        console.log(`Failed to create stream: ${WRITE_MODEL_STREAM}.`);
      }
    })
  }
})

eventStore.hasStream(PUBLIC_STREAM).then(hasStream => {
  if (!hasStream) {
    eventStore.createStream(PUBLIC_STREAM, "public").then(success => {
      if (success) {
        console.log(`${PUBLIC_STREAM} stream created.`);
      } else {
        console.log(`Failed to create stream: ${PUBLIC_STREAM}.`);
      }
    })
  }
})

interface Collection {
  name: string;
  docIdSchema?: string;
}

const collections: Collection[] = [

];

const isPostgresStore = documentStore instanceof PostgresDocumentStore;

collections.forEach(c => {
  documentStore.hasCollection(c.name).then(hasCollection => {
    if (!hasCollection) {
      let oldDocIdSchema;

      if (isPostgresStore) {
        oldDocIdSchema = documentStore.getDocIdSchema();

        if (c.docIdSchema) {
          documentStore.useDocIdSchema(c.docIdSchema);
        }
      }

      documentStore.addCollection(c.name).then(() => {
        console.log(`${c.name} collection created.`);
      });

      if (isPostgresStore && oldDocIdSchema) {
        documentStore.useDocIdSchema(oldDocIdSchema);
      }
    }
  })
})
