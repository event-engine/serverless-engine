import {generateFiles, getProjects, joinPathFragments, logger, names, Tree} from "@nrwl/devkit";
import {Schema} from "./schema";
import {
  Project,
  ScriptTarget,
  SyntaxKind,
  ObjectLiteralExpression,
} from 'ts-morph';
import {normalizeRefs, removeRefHash, unescapeSchemaFromShell} from "../../utils/escape-definitions";

const project = new Project({
  compilerOptions: {
    target: ScriptTarget.ES2020,
  },
});

export default async function (tree: Tree, schema: Schema) {
  const serviceNames = names(schema.service);
  const aggregateNames = names(schema.aggregate);
  const eventNames = names(schema.name);
  const eventSchema: any = normalizeRefs(unescapeSchemaFromShell(schema.schema), serviceNames.name);

  if (!getProjects(tree).has(schema.service)) {
    logger.error(`Service ${schema.service} does not exist.`);
    return;
  }

  const serviceRoot = `services/${serviceNames.fileName}/src`;
  const aggregateRoot = `${serviceRoot}/model/${aggregateNames.fileName}`;
  const reducerExists = tree.exists(`${aggregateRoot}/reducers/apply-${eventNames.fileName}.ts`);

  if(!tree.exists(aggregateRoot)) {
    logger.error(`Aggregate ${schema.aggregate} does not exist.`);
    return;
  }

  const toJSON = (val: any): string => {
    return JSON.stringify(val, null, 2);
  }

  if(!eventSchema.hasOwnProperty('$id')) {
    eventSchema['$id'] = `/definitions/${serviceNames.fileName}/${aggregateNames.fileName}/${eventNames.fileName}`;
  }

  generateFiles(tree, joinPathFragments(__dirname, 'files'), aggregateRoot, {
    aggregate: aggregateNames,
    service: serviceNames,
    ...eventNames,
    schema: eventSchema,
    toJSON,
    tmpl: '',
  });

  if(reducerExists) {
    return;
  }

  const reducersPath = joinPathFragments(`${aggregateRoot}`,'reducers', 'index.ts');
  const reducers = tree.read(reducersPath)!.toString();

  const sourceFile = project.createSourceFile('index.ts', reducers);
  const dec = sourceFile.getVariableDeclaration('reducers');
  const objectLiteralExpression = dec!.getInitializerIfKindOrThrow(
    SyntaxKind.ObjectLiteralExpression
  ) as ObjectLiteralExpression;

  objectLiteralExpression.addPropertyAssignment({
    name: `"${serviceNames.className}.${aggregateNames.className}.${eventNames.className}"`,
    initializer: `apply${eventNames.className},`
  });

  sourceFile.addImportDeclaration({
    defaultImport: `{apply${eventNames.className}}`,
    moduleSpecifier: `./apply-${eventNames.fileName}`
  });

  sourceFile.formatText({ indentSize: 2 });

  tree.write(reducersPath, sourceFile.getText());
}
