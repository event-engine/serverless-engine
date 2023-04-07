import {generateFiles, getProjects, joinPathFragments, logger, names, Tree} from "@nrwl/devkit";
import {Schema} from "./schema";
import {normalizeRefs, unescapeSchemaFromShell} from "../../utils/escape-definitions";

export default async function (tree: Tree, schema: Schema) {
  const serviceNames = names(schema.service);
  const eventNames = names(schema.name);
  const eventSchema: any = normalizeRefs(unescapeSchemaFromShell(schema.schema), serviceNames.name);

  if (!getProjects(tree).has(schema.service)) {
    logger.error(`Producing service ${schema.service} does not exist.`);
    return;
  }

  if(schema.eventVersion.charAt(0) !== "v") {
    logger.error('Event version should start with a lowercase "v"');
    return;
  }

  const serviceRoot = `services/${serviceNames.fileName}/src`;

  const toJSON = (val: any): string => {
    return JSON.stringify(val, null, 2);
  }

  if(!eventSchema.hasOwnProperty('$id')) {
    eventSchema['$id'] = `/definitions/${serviceNames.fileName}/${eventNames.fileName}`;
  }

  generateFiles(tree, joinPathFragments(__dirname, 'files'), serviceRoot, {
    service: serviceNames,
    ...eventNames,
    schema: eventSchema,
    version: schema.eventVersion,
    toJSON,
    tmpl: '',
  });
}
