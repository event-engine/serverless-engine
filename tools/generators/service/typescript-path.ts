import {Tree} from "@nrwl/devkit";

export const addTypeScriptPath = (host: Tree, serviceName: string, serviceRoot: string) => {
  const tsConfigBuffer = host.read('/tsconfig.base.json');

  if(tsConfigBuffer) {
    const tsConfigBase = JSON.parse(tsConfigBuffer.toString());

    const tsNs = `@app/${serviceName}/*`;

    if(!tsConfigBase.compilerOptions.paths.hasOwnProperty(tsNs)) {
      tsConfigBase.compilerOptions.paths[tsNs] = [`${serviceRoot}/src/*`];

      host.write('/tsconfig.base.json', JSON.stringify(tsConfigBase, null, 2));
    }
  }
}
