import {
  formatFiles,
  generateFiles,
  installPackagesTask,
  joinPathFragments,
  names,
  Tree,
} from '@nrwl/devkit';
import { Schema } from './schema';
import { addJest } from './jest-config';
import { addWorkspaceConfig } from './workspace-config';
import {addTypeScriptPath} from "./typescript-path";

export default async (host: Tree, schema: Schema) => {
  const serviceNames = names(schema.name);
  const serviceRoot = `services/${serviceNames.fileName}`;

  const { fileName } = serviceNames;

  generateFiles(host, joinPathFragments(__dirname, './files'), serviceRoot, {
    ...schema,
    tmpl: '',
    fileName,
  });

  addWorkspaceConfig(host, schema.name, serviceRoot);
  addTypeScriptPath(host, serviceNames.fileName, serviceRoot);

  await addJest(host, schema.name);

  await formatFiles(host);

  return () => {
    installPackagesTask(host);
  };
};
