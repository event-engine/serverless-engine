import {JSONSchema} from "json-schema-to-ts";
import {convertShorthandObjectToJsonSchema, ShorthandObject} from "@proophboard/schema-to-typescript/lib/jsonschema";
import {CodyHook, CodyResponse, CodyResponseType, Node} from "@proophboard/cody-types";
import {Context} from "./context";
import {isCodyError, nodeNameToPascalCase, parseJsonMetadata} from "@proophboard/cody-utils";
import {logger} from "@nrwl/devkit";
import {detectService, escapeSchemaForShell} from "./utils";
import {execGenerator, makeNxCmd} from "./exec-generator";
import {voWithNamespace} from "../utils/vo-helpers";

interface Meta {
  ns?: string;
  shorthand?: boolean;
  schema: JSONSchema | ShorthandObject;
  querySchema?: JSONSchema | ShorthandObject;
  service?: string;
}

export const onDocument: CodyHook<Context> = async (document: Node, ctx: Context): Promise<CodyResponse> => {

  const name = nodeNameToPascalCase(document);
  const service = detectService(document);
  const meta = parseJsonMetadata<Meta>(document);

  if(isCodyError(meta)) {
    return meta;
  }

  if(isCodyError(service)) {
    return service;
  }

  let schema = meta.schema || {};
  const ns = meta.ns || '/';

  if(meta.shorthand) {
    const convertedSchema = convertShorthandObjectToJsonSchema(schema as ShorthandObject, ns);

    if(isCodyError(convertedSchema)) {
      return convertedSchema;
    }

    schema = convertedSchema;
  }

  const schemaStr = escapeSchemaForShell(schema);

  const args = `${service} ${name} ${ns} '${schemaStr}'`;
  let voOutput = '';
  try {
    voOutput = execGenerator('vo', args);
  } catch (e) {
    logger.error(e);
    return {
      type: CodyResponseType.Error,
      cody: `Couldn't generate value object ${name}`,
      details: 'Failed to execute: ' + makeNxCmd('vo', args),
    }
  }

  if(!meta.querySchema) {
    return {
      cody: `Successfully added Value Object ${voWithNamespace(ns, name)} to the read model`,
      details: voOutput
    }
  }

  // Generate query for Value Object
  const queryName = `Get${name}`;
  let querySchema = meta.querySchema;

  if(meta.shorthand) {
    const convertedQuerySchema = convertShorthandObjectToJsonSchema(querySchema as ShorthandObject);

    if(isCodyError(convertedQuerySchema)) {
      return convertedQuerySchema;
    }

    querySchema = convertedQuerySchema;
  }

  const querySchemaStr = escapeSchemaForShell(querySchema);

  const queryArgs = `${service} ${queryName} ${voWithNamespace(ns, name)} '${querySchemaStr}'`;

  try {
    const queryOutput = execGenerator('query', queryArgs);

    return {
      type: CodyResponseType.Info,
      cody: `Successfully added Value Object ${voWithNamespace(ns, name)} and Query ${queryName} to the system`,
      details: voOutput + "\n\n" + queryOutput,
    }
  } catch (e) {
    logger.error(e);
    return {
      type: CodyResponseType.Error,
      cody: `Couldn't generate query ${queryName}`,
      details: 'Failed to execute: ' + makeNxCmd('query', queryArgs),
    }
  }
}
