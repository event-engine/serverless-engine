import {CodyHook, CodyResponse, CodyResponseType, Node, NodeType} from "@proophboard/cody-types";
import {Context} from "./context";
import {
  getSingleTarget,
  isCodyError,
  mergeWithSimilarNodes,
  nodeNameToPascalCase,
  parseJsonMetadata
} from "@proophboard/cody-utils";
import {detectService, escapeSchemaForShell} from "./utils";
import {logger, names} from "@nrwl/devkit";
import * as fs from "fs";
import {onAggregate} from "./on-aggregate";
import {convertShorthandObjectToJsonSchema, ShorthandObject} from "@proophboard/schema-to-typescript/lib/jsonschema";
import {JSONSchema, JSONSchema7} from "json-schema-to-ts";
import {execGenerator, makeNxCmd} from "./exec-generator";

interface CommandMeta {
  newAggregate: boolean;
  shorthand: boolean;
  schema: JSONSchema | ShorthandObject;
  service?: string;
}

export const onCommand: CodyHook<Context> = async (command: Node, ctx: Context) => {
  const name = nodeNameToPascalCase(command);
  const aggregate = getSingleTarget(command, NodeType.aggregate);
  const service = detectService(command);
  const meta = parseJsonMetadata<CommandMeta>(command);

  if(isCodyError(meta)) {
    return meta;
  }

  if(isCodyError(aggregate)) {
    return aggregate;
  }

  if(isCodyError(service)) {
    return service;
  }

  const newAggregate = meta.newAggregate? 'y' : 'n';
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

    arResponse = await onAggregate(syncedAggregate, ctx);

    if(isCodyError(arResponse)) {
      return arResponse;
    }
  }

  const schemaStr = escapeSchemaForShell(schema);

  const args = `${service} ${aggregateNames.className} ${name} ${newAggregate} '${schemaStr}'`;

  try {
    const output = execGenerator('command', args);

    return {
      type: CodyResponseType.Info,
      cody: 'Added command ' + name,
      details: arResponse.details + output,
    }
  } catch (e) {
    logger.error(e);
    return {
      type: CodyResponseType.Error,
      cody: `Couldn't generate command ${name}`,
      details: 'Failed to execute: ' + makeNxCmd('command', args),
    }
  }
}
