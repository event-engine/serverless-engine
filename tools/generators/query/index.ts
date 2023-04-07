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
import {nsToPath} from "../../utils/ns-to-path";
import {normalizeRefs, unescapeSchemaFromShell} from "../../utils/escape-definitions";

const project = new Project({
  compilerOptions: {
    target: ScriptTarget.ES2020,
  },
});

export default async function (tree: Tree, schema: Schema) {
  const serviceNames = names(schema.service);
  const queryNames = names(schema.name);
  const querySchema: any = normalizeRefs(unescapeSchemaFromShell(schema.schema), serviceNames.name);
  const returnTypePath = nsToPath(schema.return);
  const returnType = schema.return.split("/").pop() || '';
  const returnTypeNames = names(returnType);

  if (!getProjects(tree).has(schema.service)) {
    logger.error(`Service ${schema.service} does not exist.`);
    return;
  }

  const serviceRoot = `services/${serviceNames.fileName}/src`;
  const readModelRoot = `${serviceRoot}/read-model`;
  const httpRoot = `${serviceRoot}/http`;
  const httpHandlerExists = tree.exists(`${httpRoot}/${queryNames.fileName}-handler.ts`);

  const toJSON = (val: any): string => {
    return JSON.stringify(val, null, 2);
  }

  if(!querySchema.hasOwnProperty('$id')) {
    querySchema['$id'] = `/definitions/${serviceNames.fileName}/${queryNames.fileName}`;
  }

  generateFiles(tree, joinPathFragments(__dirname, 'files', 'http'), httpRoot, {
    service: serviceNames,
    ...queryNames,
    tmpl: '',
  });

  generateFiles(tree, joinPathFragments(__dirname, 'files', 'read-model'), readModelRoot, {
    service: serviceNames,
    ...queryNames,
    schema: querySchema,
    returnType: returnTypeNames,
    returnTypePath,
    toJSON,
    tmpl: '',
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
        handler: `'src/http/${queryNames.fileName}-handler.main'`,
        events: (writer) => {
          writer.write('[');
          Writers.object({
            http: Writers.object({
              method: `'get'`,
              path: `'/${serviceNames.fileName}/api/messages/${queryNames.fileName}'`,
              cors: `true`
            }),
          })(writer);
          writer.write(']');
        },
      })(writer);
    },
    name: `'${queryNames.fileName}'`,
  });

  sourceFile.formatText({ indentSize: 2 });

  tree.write(serverlessPath, sourceFile.getText());
}
