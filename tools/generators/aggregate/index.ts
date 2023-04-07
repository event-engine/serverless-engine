import {generateFiles, getProjects, joinPathFragments, logger, names, Tree} from "@nrwl/devkit";
import {Schema} from "./schema";
import {
  Project,
  ScriptTarget,
  SyntaxKind,
  ArrayLiteralExpression,
} from 'ts-morph';

const project = new Project({
  compilerOptions: {
    target: ScriptTarget.ES2020,
  },
});

export default async function (tree: Tree, schema: Schema) {
  const serviceNames = names(schema.service);
  const aggregateNames = names(schema.name);
  const identifierNames = names(schema.identifier);

  if (!getProjects(tree).has(schema.service)) {
    logger.error(`Service ${schema.service} does not exist.`);

    return;
  }

  const serviceRoot = `services/${serviceNames.fileName}/src`;
  const aggregateRoot = `${serviceRoot}/model/${aggregateNames.fileName}`;

  if(tree.exists(aggregateRoot)) {
    logger.warn(`Aggregate ${schema.name} already exists`);
    return;
  }

  const prepareDbPath = joinPathFragments(`services/core`, 'preparedb.ts');
  const preparedb = tree.read(prepareDbPath)!.toString();

  generateFiles(tree, joinPathFragments(__dirname, './files'), aggregateRoot, {
    tmpl: '',
    ...aggregateNames,
    lowerConstantName: aggregateNames.constantName.toLowerCase(),
    service: serviceNames.className,
    identifier: identifierNames.propertyName,
  });

  const sourceFile = project.createSourceFile('preparedb.ts', preparedb);
  const dec = sourceFile.getVariableDeclaration('collections');
  const arrayLiteralExpression = dec!.getInitializerIfKindOrThrow(
    SyntaxKind.ArrayLiteralExpression
  ) as ArrayLiteralExpression;

  arrayLiteralExpression.addElement(`{name: ${aggregateNames.constantName}_COLLECTION}`);

  sourceFile.addImportDeclaration({
    defaultImport: `{${aggregateNames.constantName}_COLLECTION}`,
    moduleSpecifier: `@app/${serviceNames.fileName}/model/${aggregateNames.fileName}/repository`
  })

  sourceFile.formatText({ indentSize: 2 });

  tree.write(prepareDbPath, sourceFile.getText());
}
