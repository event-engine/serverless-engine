import {PostgresFilterProcessor} from "@app/infrastructure/DocumentStore/Postgres/PostgresFilterProcessor";
import {Filter} from "@app/infrastructure/DocumentStore/Filter";
import {PartialSelect, SortOrder} from "@app/infrastructure/DocumentStore";
import {Index} from "@app/infrastructure/DocumentStore/Index";
import {PostgresIndexProcessor} from "@app/infrastructure/DocumentStore/Postgres/PostgresIndexProcessor";
import {MetadataFieldIndex} from "@app/infrastructure/DocumentStore/Index/MetadataFieldIndex";

export const PARTIAL_SELECT_DOC_ID = '__partial_sel_doc_id__';
export const PARTIAL_SELECT_MERGE = '__partial_sel_merge__';

export const RESERVED_ALIASES = [
  PARTIAL_SELECT_DOC_ID,
  PARTIAL_SELECT_MERGE,
];

export type PostgresQuery = [string, any[]];

export class PostgresQueryBuilder {

  private filterProcessor: PostgresFilterProcessor;
  private indexProcessor: PostgresIndexProcessor;

  constructor(filterProcessor: PostgresFilterProcessor, indexProcessor: PostgresIndexProcessor) {
    this.filterProcessor = filterProcessor;
    this.indexProcessor = indexProcessor;
  }

  public makeAddDocQuery(collectionName: string, docId: string, doc: object, metadata?: object): PostgresQuery {
    const { metaKeys, metaValues, metaBindings } = this.extractMetadata(3, metadata);

    const queryString = `
      INSERT INTO ${this.tableName(collectionName)} (id, doc ${metaKeys})
      VALUES ($1, $2 ${metaBindings})
    `;

    const bindings = [docId, doc, ...metaValues];

    return [queryString, bindings];
  }

  public makeUpdateDocQuery(collectionName: string, docId: string, docOrSubset: object, metadata?: object): PostgresQuery {
    const bindings = [docId, docOrSubset];

    const metaUpdate = this.applyMetadataForUpdate(bindings, metadata);

    const queryString = `
      UPDATE ${this.tableName(collectionName)}
      SET doc = (to_jsonb(doc) || $2) ${metaUpdate}
      WHERE id = $1
    `;

    return [queryString, bindings];
  }

  public makeUpdateManyQuery(collectionName: string, filter: Filter, set: object): PostgresQuery {
    const filterClause = this.filterProcessor.process(filter);
    let argumentCounter = filterClause[1].length;

    const queryString = `
      UPDATE ${this.tableName(collectionName)}
      SET doc = (to_jsonb(doc) || $${++argumentCounter})
      WHERE ${filterClause[0]};
    `;

    const bindings = [...filterClause[1], JSON.stringify(set)];

    return [queryString, bindings];
  }

  public makeUpsertDocQuery(collectionName: string, docId: string, doc: object, metadata?: object): PostgresQuery {
    const tableName = this.tableName(collectionName);
    const { metaKeys, metaValues, metaBindings } = this.extractMetadata(3, metadata);

    const conflictMetaUpdateClause = metadata
      ? ', ' + Object.keys(metadata).map(key => `${key} = EXCLUDED.${key}`).join(', ')
      : '';

    const queryString = `
      INSERT INTO ${tableName} (id, doc ${metaKeys})
      VALUES ($1, $2 ${metaBindings})
      ON CONFLICT (id)
      DO
        UPDATE SET doc = (to_jsonb(${tableName}.doc) || EXCLUDED.doc) ${conflictMetaUpdateClause}
        WHERE ${tableName}.id = EXCLUDED.id;
    `;

    const bindings = [docId, doc, ...metaValues];

    return [queryString, bindings];
  }

  public makeReplaceDocQuery(collectionName: string, docId: string, doc: object, metadata?: object): PostgresQuery {
    const bindings = [docId, JSON.stringify(doc)];

    const metaUpdate = this.applyMetadataForUpdate(bindings, metadata);

    const queryString = `
      UPDATE ${this.tableName(collectionName)}
      SET doc = $2 ${metaUpdate}
      WHERE id = $1;
    `;

    return [queryString, bindings];
  }

  public makeReplaceManyQuery(collectionName: string, filter: Filter, set: object): PostgresQuery {
    const filterClause = this.filterProcessor.process(filter);
    let argumentCounter = filterClause[1].length;

    const queryString = `
      UPDATE ${this.tableName(collectionName)}
      SET doc = $${++argumentCounter}
      WHERE ${filterClause[0]};
    `;

    const bindings = [...filterClause[1], JSON.stringify(set)];

    return [queryString, bindings];
  }

  public makeDeleteDocQuery(collectionName: string, docId: string): PostgresQuery {
    const queryString = `
        DELETE FROM ${this.tableName(collectionName)}
        WHERE id = $1;
      `;

    const bindings = [docId];

    return [queryString, bindings];
  }

  public makeDeleteManyQuery(collectionName: string, filter: Filter): PostgresQuery {
    const filterClause = this.filterProcessor.process(filter);

    const queryString = `
      DELETE FROM ${this.tableName(collectionName)}
      WHERE ${filterClause[0]};
    `;

    return [queryString, filterClause[1]];
  }

  public makeCountDocsQuery(collectionName: string, filter: Filter): PostgresQuery {
    const filterClause = this.filterProcessor.process(filter);

    const queryString = `
      SELECT count(doc)
      FROM ${this.tableName(collectionName)}
      WHERE ${filterClause[0]};
    `;

    return [queryString, filterClause[1]];
  }

  public makeGetDocQuery(collectionName: string, docId: string): PostgresQuery {
    const queryString = `
      SELECT *
      FROM ${this.tableName(collectionName)}
      WHERE id = $1
    `;

    const bindings = [docId];

    return [queryString, bindings];
  }

  public makeGetPartialDocQuery(collectionName: string, docId: string, partialSelect: PartialSelect): PostgresQuery {
    const queryString = `
      SELECT ${this.makePartialDocSelect(partialSelect)}
      FROM ${this.tableName(collectionName)}
      WHERE id = $1
    `;

    const bindings = [docId];

    return [queryString, bindings];
  }

  public makeFindDocsQuery(collectionName: string, filter: Filter, skip?: number, limit?: number, orderBy?: SortOrder): PostgresQuery {
    const filterClause = this.filterProcessor.process(filter);

    const offsetClause = skip ? `OFFSET ${skip}` : '';
    const limitClause = limit ? `LIMIT ${limit}` : '';
    const orderByClause = orderBy ? this.makeOrderByClause(orderBy) : '';

    const queryString = `
      SELECT id, doc
      FROM ${this.tableName(collectionName)}
      WHERE ${filterClause[0]}
      ${orderByClause}
      ${limitClause}
      ${offsetClause};
    `;

    return [queryString, filterClause[1]];
  }

  public makeFindPartialDocsQuery(collectionName: string, partialSelect: PartialSelect, filter: Filter, skip?: number, limit?: number, orderBy?: SortOrder): PostgresQuery {
    const filterClause = this.filterProcessor.process(filter);

    const offsetClause = skip ? `OFFSET ${skip}` : '';
    const limitClause = limit ? `LIMIT ${limit}` : '';
    const orderByClause = orderBy ? this.makeOrderByClause(orderBy) : '';

    const queryString = `
      SELECT ${this.makePartialDocSelect(partialSelect)}
      FROM ${this.tableName(collectionName)}
      WHERE ${filterClause[0]}
      ${orderByClause}
      ${limitClause}
      ${offsetClause};
    `;

    return [queryString, filterClause[1]];
  }

  public makeFindDocIdsQuery(collectionName: string, filter: Filter, skip?: number, limit?: number, orderBy?: SortOrder): PostgresQuery {
    const filterClause = this.filterProcessor.process(filter);

    const offsetClause = skip ? `OFFSET ${skip}` : '';
    const limitClause = limit ? `LIMIT ${limit}` : '';
    const orderByClause = orderBy ? this.makeOrderByClause(orderBy) : '';

    const queryString = `
      SELECT id
      FROM ${this.tableName(collectionName)}
      WHERE ${filterClause[0]}
      ${orderByClause}
      ${limitClause}
      ${offsetClause};
    `;

    return [queryString, filterClause[1]];
  }

  public makeHasCollectionQuery(collectionName: string): PostgresQuery {
    const queryString = `
      SELECT EXISTS (
        SELECT FROM
          information_schema.tables
        WHERE
          table_schema LIKE 'public' AND
          table_type LIKE 'BASE TABLE' AND
          table_name = $1
      );
    `;

    const bindings = [this.tableName(collectionName)];

    return [queryString, bindings];
  }

  public makeAddCollectionQuery(collectionName: string, docIdSchema: string): PostgresQuery {
    const queryString = `
      CREATE TABLE ${this.tableName(collectionName)}
      (id ${docIdSchema},
      doc JSONB NOT NULL,
      PRIMARY KEY (id));
    `;

    return [queryString, []];
  }

  public makeDropCollectionQuery(collectionName: string): PostgresQuery {
    const queryString = `DROP TABLE IF EXISTS ${this.tableName(collectionName)}`;

    return [queryString, []];
  }

  public makeAddCollectionIndexQuery(collectionName: string, index: Index): PostgresQuery {
    const queryString = this.indexProcessor.process(index, this.tableName(collectionName));

    return [queryString, []];
  }

  public makeAddCollectionMetadataColumnQuery(collectionName: string, index: MetadataFieldIndex): PostgresQuery {
    const queryString = `
      ALTER TABLE ${this.tableName(collectionName)}
      ADD COLUMN ${index.field} VARCHAR;
    `;

    return [queryString, []];
  }

  public makeHasCollectionIndexQuery(collectionName: string, index: Index): PostgresQuery {
    const tableName = this.tableName(collectionName);

    const queryString = `
      SELECT INDEXNAME
      FROM pg_indexes
      WHERE TABLENAME = '${tableName}'
      AND SCHEMANAME = 'public'
      AND INDEXNAME = $1;
    `;

    return [queryString, [index.name]];
  }

  public makeDropCollectionIndexQuery(collectionName: string, index: Index): PostgresQuery {
    const queryString = `
      DROP INDEX ${index.name};
    `;

    return [queryString, []];
  }

  public makeDropCollectionMetadataColumnQuery(collectionName: string, index: MetadataFieldIndex): PostgresQuery {
    const queryString = `
      ALTER TABLE ${this.tableName(collectionName)}
      DROP COLUMN ${index.field};
    `;

    return [queryString, []];
  }



  private makePartialDocSelect(partialSelect: Array<string|[string, string]>): string {
    let select = `id as "${PARTIAL_SELECT_DOC_ID}", `;

    for (const item of partialSelect) {
      const isStringItem = typeof item === 'string';

      let alias = isStringItem ? item : item[0];
      const field = isStringItem ? item : item[1];

      if (RESERVED_ALIASES.includes(alias)) {
        throw new Error(`Invalid select alias. You cannot use ${alias} as alias, because it is reserved for internal use`);
      }

      if (alias === '$merge') {
        alias = PARTIAL_SELECT_MERGE;
      }

      select += `${this.propToJsonPath(field)} as "${alias}", `;
    }

    return select.slice(0, -2);
  }

  private extractMetadata(argumentOffsetCounter: number, metadata?: object): { metaKeys: string, metaValues: any[], metaBindings: string } {
    const metaKeys = metadata ? ', ' + Object.keys(metadata).join(', ') : '';
    const metaValues = metadata ? Object.values(metadata) : [];
    const metaBindings = metadata ? ', ' + metaValues.map((_, index) => `$${argumentOffsetCounter + index}`).join(', ') : '';

    return { metaKeys, metaValues, metaBindings };
  }

  private applyMetadataForUpdate(bindings: any[], metadata?: object): string {
    return metadata
      ? ', ' + Object.keys(metadata).map(key => `${key} = $${bindings.push((metadata as any)[key])}`).join(', ')
      : '';
  }

  private makeOrderByClause(orderBy: SortOrder): string {
    return `ORDER BY ${orderBy.map(({ prop, sort }) => `${this.propToJsonPath(prop)} ${sort.toUpperCase()}`).join(', ')}`;
  }

  // @todo code duplication with PostgresFilterProcessor
  private propToJsonPath(field: string): string {
    return `doc->'${field.replace('.', "'->'")}'`;
  }

  private tableName(collectionName: string): string {
    return collectionName.toLowerCase();
  }
}
