import {IndexProcessor} from "@app/infrastructure/DocumentStore/IndexProcessor";

export interface Index {
  readonly name: string;

  processWith: (indexProcessor: IndexProcessor, tableName: string) => any;
}

