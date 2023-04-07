import {CodyHook, CodyResponse, CodyResponseType, Node, NodeType} from "@proophboard/cody-types";
import {Context} from "./context";
import {isCodyError, nodeNameToPascalCase, parseJsonMetadata} from "@proophboard/cody-utils";
import {names} from "@nrwl/devkit";
import * as fs from "fs";
import {execGenerator, makeNxCmd} from "./exec-generator";
import {detectService} from "./utils";

interface Meta {
  identifier: string;
  service?: string;
}

export const onAggregate: CodyHook<Context> = async (aggregate: Node, ctx: Context): Promise<CodyResponse> => {
  const name = nodeNameToPascalCase(aggregate);

  const meta = parseJsonMetadata<Meta>(aggregate);

  if(isCodyError(meta)) {
    return meta;
  }

  if(!meta.identifier) {
    return {
      type: CodyResponseType.Error,
      cody: `No aggregate identifier set in metadata for aggregate ${aggregate.getName()}`
    }
  }

  const service = detectService(aggregate);

  if(isCodyError(service)) return service;

  const serviceNames = names(service);

  let serviceOutput = '';

  if(!fs.existsSync(`services/${serviceNames.fileName}`)) {
    try {
      serviceOutput = execGenerator('service', service);
    } catch (e) {
      return {
        type: CodyResponseType.Error,
        cody: `Couldn't create service ${service} for aggregate ${aggregate.getName()}`,
        details: 'Failed to execute: ' + makeNxCmd('service', service),
      }
    }
  }

  const args = service + ' ' + name + ' ' + meta.identifier;

  try {
    const output = execGenerator('aggregate', args);

    return {
      type: CodyResponseType.Info,
      cody: 'Added aggregate ' + name,
      details: serviceOutput + output,
    }
  } catch (e) {
    return {
      type: CodyResponseType.Error,
      cody: `Couldn't generate Aggregate ${aggregate.getName()}`,
      details: 'Failed to execute: ' + makeNxCmd('aggregate', args),
    }
  }
}
