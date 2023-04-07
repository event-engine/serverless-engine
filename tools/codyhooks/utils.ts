import {CodyResponse, CodyResponseType, Node, NodeType} from "@proophboard/cody-types";
import {isCodyError, nodeNameToPascalCase, parseJsonMetadata} from "@proophboard/cody-utils";
import {names} from "@nrwl/devkit";
import {JSONSchema7} from "json-schema";
import {JSONSchema} from "json-schema-to-ts";

export const findBc = (node: Node | null): Node | null => {
  if(node && node.getType() === NodeType.boundedContext) {
    return node;
  }

  if(!node) {
    return null;
  }

  return findBc(node.getParent());
}

export const findFeature = (node: Node | null): Node | null => {
  if(node && node.getType() === NodeType.feature) {
    return node;
  }

  if(!node) {
    return null;
  }

  return findFeature(node.getParent());
}

export const detectService = (node: Node): string | CodyResponse => {
  const meta = parseJsonMetadata<{service?: string}>(node);

  if(isCodyError(meta)) {
    return meta;
  }

  if(meta.service && typeof meta.service === 'string') {
    return meta.service;
  }

  const bc = findBc(node);

  if(bc) {
    return names(nodeNameToPascalCase(bc)).className;
  }

  const feature = findFeature(node);

  if(feature) {
    const featureMeta = parseJsonMetadata<{service?: string}>(feature);

    if(isCodyError(featureMeta)) {
      return {
        type: CodyResponseType.Error,
        cody: `I tried to read the service for ${node.getName()} from its parent feature ${feature.getName()}, but there seems to be a problem with the metadata of the feature!`,
        details: featureMeta.cody + "\n\n" + featureMeta.details
      }
    }

    if(featureMeta.service) {
      return names(featureMeta.service).className;
    }
  }

  return {
    type: CodyResponseType.Error,
    cody: `Cannot detect service for ${node.getType()} ${node.getName()}`,
    details: `Either define "service" in metadata (e.g. of feature frame) or put the ${node.getType()} in a Bounded Context`
  }
}

export const escapeSchemaForShell = (schema: JSONSchema): string => {
  return JSON.stringify(schema).replace(/\$/g, '__dollarsign__');
}
