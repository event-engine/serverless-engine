import {names} from "@nrwl/devkit";

export const nsToPath = (ns: string): string => {
  return '/' + ns.split("/")
    // Rm leading empty part
    .filter(p => p !== '')
    // A type can end with [] to identify it as array of type
    .map(p => names(p.replace('[]', '')).fileName)
    .join("/");
}
