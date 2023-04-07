import {generateFiles, getProjects, joinPathFragments, logger, names, Tree} from "@nrwl/devkit";
import {Schema} from "./schema";
import {normalizeRefs, unescapeSchemaFromShell} from "../../utils/escape-definitions";
import {voDefinitionId, voImportFromDefinitionId, voPath} from "../../utils/vo-helpers";
import {
  ArrayLiteralExpression, NamedTupleMember,
  ObjectLiteralExpression,
  Project,
  ScriptTarget,
  SyntaxKind,
  TupleTypeNode, TypeQueryNode,
} from 'ts-morph';

const project = new Project({
  compilerOptions: {
    target: ScriptTarget.ES2020,
  },
});

export default async function (tree: Tree, schema: Schema) {
  const serviceNames = names(schema.service);
  const voNames = names(schema.name);
  const dotNamespace = schema.namespace.split("/").filter(p => p !== '').join(".");
  const voSchema: any = normalizeRefs(unescapeSchemaFromShell(schema.schema), serviceNames.name);

  if (!getProjects(tree).has(schema.service)) {
    logger.error(`Service ${schema.service} does not exist.`);
    return;
  }

  const typeRoot = voPath(schema.service, schema.namespace);

  const toJSON = (val: any): string => {
    return JSON.stringify(val, null, 2);
  }

  const definitionId = voDefinitionId(schema.service, schema.namespace, voNames.className);

  voSchema['$id'] = definitionId;
  let typeExists = false;

  if(tree.exists(`${typeRoot}/${voNames.fileName}.ts`)) {
    typeExists = true;
    tree.delete(`${typeRoot}/${voNames.fileName}.ts`);
  }

  generateFiles(tree, joinPathFragments(__dirname, 'files'), typeRoot, {
    service: serviceNames,
    ...voNames,
    schema: voSchema,
    dotNamespace,
    toJSON,
    tmpl: '',
  });

  if(typeExists) {
    return;
  }

  const typesPath = joinPathFragments(`services/${serviceNames.fileName}`, 'src', 'read-model', 'types');
  const definitionsPath = joinPathFragments(typesPath, 'definitions.ts');
  const referencesPath = joinPathFragments(typesPath, 'references.ts');
  const definitions = tree.read(definitionsPath)!.toString();
  const references = tree.read(referencesPath)!.toString();

  // Start manipulating definitions.ts
  const definitionsFile = project.createSourceFile('definitions.ts', definitions);
  const dec = definitionsFile.getVariableDeclaration('definitions');
  const objectLiteralExpression = dec!.getInitializerIfKindOrThrow(
    SyntaxKind.ObjectLiteralExpression
  ) as ObjectLiteralExpression;

  objectLiteralExpression.addPropertyAssignment({
    name: `'${definitionId}'`,
    initializer: `${voNames.className}Schema`
  })

  definitionsFile.addImportDeclaration({
    defaultImport: `{${voNames.className}Schema}`,
    moduleSpecifier: voImportFromDefinitionId(definitionId) + ".schema",
  })

  definitionsFile.formatText({ indentSize: 2 });
  tree.write(definitionsPath, definitionsFile.getText());
  // End manipulating definitions.ts

  // Start manipulating references.ts
  const referencesFile = project.createSourceFile('references.ts', references);
  const typeAlias = referencesFile.getTypeAliasOrThrow('references');
  const tuple = typeAlias.getTypeNodeOrThrow() as TupleTypeNode;

  let tupleText = '';
  if(tuple.getText() === '[]') {
    tupleText = tuple.getText().replace("]", `\n  typeof ${voNames.className}Schema\n]`);
  } else {
    tupleText = tuple.getText().replace("\n]", `,\n  typeof ${voNames.className}Schema\n]`);
  }

  tuple.replaceWithText(tupleText)

  referencesFile.addImportDeclaration({
    defaultImport: `{${voNames.className}Schema}`,
    moduleSpecifier: voImportFromDefinitionId(definitionId) + ".schema",
  })

  referencesFile.formatText({ indentSize: 2 });
  tree.write(referencesPath, referencesFile.getText());
  // End manipulating references.ts
}
