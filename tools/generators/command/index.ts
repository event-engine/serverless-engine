import {generateFiles, getProjects, joinPathFragments, logger, names, Tree} from "@nrwl/devkit";
import {Schema} from "./schema";
import {
  Project,
  ScriptTarget,
  SyntaxKind,
  ObjectLiteralExpression,
  Writers,
  PropertyAssignment,
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
  const commandNames = names(schema.name);
  const cmdSchema: any = normalizeRefs(unescapeSchemaFromShell(schema.schema), serviceNames.name);
  const newAggregate = schema.newAggregate === 'y';

  if (!getProjects(tree).has(schema.service)) {
    logger.error(`Service ${schema.service} does not exist.`);
    return;
  }

  const serviceRoot = `services/${serviceNames.fileName}/src`;
  const httpRoot = `${serviceRoot}/http`;
  const dispatchRoot = `${serviceRoot}/command-bus`;
  const aggregateRoot = `${serviceRoot}/model/${aggregateNames.fileName}`;
  const httpHandlerExists = tree.exists(`${httpRoot}/${commandNames.fileName}-handler.ts`);

  if(!tree.exists(aggregateRoot)) {
    logger.error(`Aggregate ${schema.aggregate} does not exist.`);
    return;
  }

  const toJSON = (val: any): string => {
    return JSON.stringify(val, null, 2);
  }

  if(!cmdSchema.hasOwnProperty('$id')) {
    cmdSchema['$id'] = `/definitions/${serviceNames.fileName}/${aggregateNames.fileName}/${commandNames.fileName}`;
  }

  const subs = {
    aggregate: aggregateNames,
    service: serviceNames,
    ...commandNames,
    newAggregate,
    toJSON,
    tmpl: '',
  };


  generateFiles(tree, joinPathFragments(__dirname, 'files', 'http'), httpRoot, subs);

  generateFiles(tree, joinPathFragments(__dirname, 'files', 'command-bus'), dispatchRoot, subs);

  generateFiles(tree, joinPathFragments(__dirname, 'files', 'model'), aggregateRoot, {
    ...subs,
    schema: cmdSchema,
  });

  if(httpHandlerExists) {
    return;
  }

  const serverlessPath = joinPathFragments(`services/${serviceNames.fileName}`, 'serverless.ts');
  const serverless = tree.read(serverlessPath)!.toString();

  const sourceFile = project.createSourceFile('serverless.ts', serverless);
  const dec = sourceFile.getVariableDeclaration('serverlessConfig');
  const objectLiteralExpression = dec!.getInitializerIfKindOrThrow(
    SyntaxKind.ObjectLiteralExpression
  ) as ObjectLiteralExpression;

  const funcProp = objectLiteralExpression.getProperty(
    'functions'
  ) as PropertyAssignment;

  const funcValue = funcProp.getInitializer() as ObjectLiteralExpression;

  funcValue.addPropertyAssignment({
    initializer: (writer) => {
      return Writers.object({
        handler: `'src/http/${commandNames.fileName}-handler.main'`,
        events: (writer) => {
          writer.write('[');
          Writers.object({
            http: Writers.object({
              method: `'post'`,
              path: `'/${serviceNames.fileName}/api/messages/${commandNames.fileName}'`,
              cors: `true`
            }),
          })(writer);
          writer.write(']');
        },
      })(writer);
    },
    name: `'${commandNames.fileName}'`,
  });

  sourceFile.formatText({ indentSize: 2 });

  tree.write(serverlessPath, sourceFile.getText());
}
