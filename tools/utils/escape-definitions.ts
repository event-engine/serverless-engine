import {JSONSchema} from "json-schema-to-ts";
import {names} from "@nrwl/devkit";

export const unescapeSchemaFromShell = (schema: string): JSONSchema => {
  return JSON.parse(schema.replace(/__dollarsign__/g, '$'));
}

export const normalizeRefs = (schema: JSONSchema, service: string): JSONSchema => {
  return visitRef(schema, ref => {
    const refParts = ref.split("/");
    if(refParts.length === 0) {
      return ref;
    }

    if(refParts[0] === "#" || refParts[0] === "") {
      refParts.shift();
    }

    // index 0 should be "definitions" now and 1 the service, if not add service part
    if(refParts.length < 2) {
      return names(refParts[0]).fileName;
    }

    const serviceNames = names(service);

    if(refParts[1] !== serviceNames.fileName) {
      refParts.splice(1, 0, serviceNames.fileName, 'read-model', 'types');
    }

    return '/' + refParts.map(p => names(p).fileName).join('/');
  })
}

export const removeRefHash = (schema: JSONSchema): JSONSchema => {
  // Needed for json-schema-to-ts reference resolution, which fails on leading # in references
  return replaceRef(schema, '#/definitions', '/definitions');
}

export const addRefHash = (schema: JSONSchema): JSONSchema => {
  return replaceRef(schema, '/definitions', '#/definitions');
}

const replaceRef = (schema: JSONSchema, search: string, replace: string): JSONSchema => {
  return visitRef(schema, (ref) => ref.replace(search, replace));
}

const visitRef = (schema: JSONSchema, visitor: (ref: string) => string): JSONSchema => {
  const internalSchema: any = schema;

  if(internalSchema['$id']) {
    internalSchema['$id'] = visitor(internalSchema['$id']);
  }

  if(internalSchema['$ref']) {
    internalSchema['$ref'] = visitor(internalSchema['$ref']);
  }

  if(internalSchema['properties']) {
    for (const prop in internalSchema['properties']) {
      internalSchema['properties'][prop] = visitRef(internalSchema['properties'][prop], visitor);
    }
  }

  if(internalSchema['items']) {
    internalSchema['items'] = visitRef(internalSchema['items'] as JSONSchema, visitor);
  }

  return internalSchema as JSONSchema;
}


