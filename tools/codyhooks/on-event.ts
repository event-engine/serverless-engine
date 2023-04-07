import {CodyHook, CodyResponse, CodyResponseType, Node, NodeType} from "@proophboard/cody-types";
import {Context} from "./context";
import {JSONSchema} from "json-schema-to-ts";
import {convertShorthandObjectToJsonSchema, ShorthandObject} from "@proophboard/schema-to-typescript/lib/jsonschema";
import {
  getSingleSource,
  isCodyError,
  mergeWithSimilarNodes,
  nodeNameToPascalCase,
  parseJsonMetadata
} from "@proophboard/cody-utils";
import {detectService, escapeSchemaForShell} from "./utils";
import {logger, names} from "@nrwl/devkit";
import * as fs from "fs";
import {onAggregate} from "./on-aggregate";
import {execGenerator, makeNxCmd} from "./exec-generator";

interface EventMeta {
  shorthand: boolean;
  schema: JSONSchema | ShorthandObject;
  service?: string;
}

export const onEvent: CodyHook<Context> = async (event: Node, ctx: Context): Promise<CodyResponse> => {
  const name = nodeNameToPascalCase(event);
  const aggregate = getSingleSource(event, NodeType.aggregate);
  const service = detectService(event);
  const meta = parseJsonMetadata<EventMeta>(event);

  if(isCodyError(meta)) {
    return meta;
  }

  if(isCodyError(aggregate)) {
    return aggregate;
  }

  if(isCodyError(service)) {
    return service;
  }

  let schema = meta.schema || {};

  if(meta.shorthand) {
    const convertedSchema = convertShorthandObjectToJsonSchema(schema as ShorthandObject);

    if(isCodyError(convertedSchema)) {
      return convertedSchema;
    }

    schema = convertedSchema;
  }

  const serviceNames = names(service);
  const aggregateNames = names(nodeNameToPascalCase(aggregate));

  const aggregateRoot = `services/${serviceNames.fileName}/src/model/${aggregateNames.fileName}`;
  let arResponse: CodyResponse = {cody: '', details: ''};

  if(!fs.existsSync(aggregateRoot)) {
    const syncedAggregate = mergeWithSimilarNodes(aggregate, ctx.syncedNodes);

    const arResponse = await onAggregate(syncedAggregate, ctx);

    if(isCodyError(arResponse)) {
      return arResponse;
    }
  }

  const schemaStr = escapeSchemaForShell(schema);

  const args = `${service} ${aggregateNames.className} ${name} '${schemaStr}'`;

  try {
    const output = execGenerator('event', args);

    return {
      type: CodyResponseType.Info,
      cody: 'Added event ' + name,
      details: arResponse.details + output,
    }
  } catch (e) {
    logger.error(e);
    return {
      type: CodyResponseType.Error,
      cody: `Couldn't generate evnet ${name}`,
      details: 'Failed to execute: ' + makeNxCmd('event', args),
    }
  }
}
