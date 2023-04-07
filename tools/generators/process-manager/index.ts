import {generateFiles, getProjects, joinPathFragments, logger, names, Tree} from "@nrwl/devkit";
import {Schema} from "./schema";
import {
  Project,
  ScriptTarget,
  SyntaxKind,
  ObjectLiteralExpression,
  Writers,
  PropertyAssignment, ArrayLiteralExpression,
} from 'ts-morph';
import {normalizeEventName} from "../../utils/normalize-event-name";

const project = new Project({
  compilerOptions: {
    target: ScriptTarget.ES2020,
  },
});

export default async function (tree: Tree, schema: Schema) {
  const serviceNames = names(schema.service);
  const pmNames = names(schema.name);
  const eventNames = names(normalizeEventName(schema.event));
  const isPublicEvent = schema.isPublicEvent === "y";
  const aggregateNames = names(schema.aggregate);

  if (!getProjects(tree).has(schema.service)) {
    logger.error(`Service ${schema.service} does not exist.`);
    return;
  }

  if(!isPublicEvent) {
    if(!tree.exists(`services/${serviceNames.fileName}/src/model/${aggregateNames.fileName}`)) {
      logger.error(`Aggregate ${schema.aggregate} does not exist, but is required for a non public event.`);
      return;
    }
  }

  const serviceRoot = `services/${serviceNames.fileName}/src`;
  const eventPath = serviceRoot + (
    isPublicEvent? `/async/consuming`
      : `/model/${aggregateNames.fileName}/events`
  ) + `/${eventNames.fileName}.ts`;

  if(!tree.exists(eventPath)) {
    logger.error(`Event: ${schema.event} not found in: ${eventPath}`);
    return;
  }

  if(tree.exists(`${serviceRoot}/async/listeners/${pmNames.fileName}.ts`)) {
    logger.info(`A process manager with name ${schema.name} exists already`);
    return;
  }

  generateFiles(tree, joinPathFragments(__dirname, 'files'), serviceRoot, {
    ...pmNames,
    aggregate: aggregateNames,
    service: serviceNames,
    event: eventNames,
    isPublicEvent,
    tmpl: '',
  });

  const listenersPath = joinPathFragments(serviceRoot, 'async', 'listeners', 'index.ts');
  const listenersFile = tree.read(listenersPath)!.toString();
  const sourceFile = project.createSourceFile('index.ts', listenersFile);
  const listeners = sourceFile.getVariableDeclaration('listeners');
  const objectLiteralExpression = listeners!.getInitializerIfKindOrThrow(
    SyntaxKind.ObjectLiteralExpression
  ) as ObjectLiteralExpression;

  let eventProp = objectLiteralExpression.getProperty(`"${schema.event}"`) as PropertyAssignment;

  // Try with single quotes again
  if(!eventProp) {
    eventProp = objectLiteralExpression.getProperty(`'${schema.event}'`) as PropertyAssignment;
  }

  if(!eventProp) {
    eventProp = objectLiteralExpression.addPropertyAssignment({
      name: `"${schema.event}"`,
      initializer: '[]'
    })
  }

  const listenerArray = eventProp.getInitializer() as ArrayLiteralExpression;
  listenerArray.addElement(`${pmNames.propertyName}`);

  sourceFile.addImportDeclaration({
    defaultImport: `{${pmNames.propertyName}}`,
    moduleSpecifier: `@app/${serviceNames.fileName}/async/listeners/${pmNames.fileName}`,
  })

  sourceFile.formatText({ indentSize: 2 });

  tree.write(listenersPath, sourceFile.getText());
}
