import {execSync} from "child_process";

type Generator = 'service' | 'aggregate' | 'command' | 'event' | 'query' | 'vo';

export const makeNxCmd = (generator: Generator, args): string => {
  return `npx nx workspace-generator ${generator} ${args} --verbose`;
}

export const execGenerator = (generator: Generator, args: string): string => {
  const result = execSync(makeNxCmd(generator, args));

  return result.toString();
}
