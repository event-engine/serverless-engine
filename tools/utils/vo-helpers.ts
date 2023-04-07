import {names} from "@nrwl/devkit";
import {nsToPath} from "./ns-to-path";

export const voWithNamespace = (namespace: string, voName: string): string => {
  if(namespace === "") {
    namespace = "/";
  }

  if(namespace === "/") {
    return namespace + voName;
  }

  return `${namespace}/${voName}`;
}

export const voDefinitionId = (service: string, namepsace: string, voName: string): string => {
  namepsace = nsToPath(namepsace);

  if(namepsace.charAt(0) !== '/') {
    namepsace = '/' + namepsace;
  }

  return `/definitions/${names(service).fileName}/read-model/types${namepsace}/${names(voName).fileName}`;
}

export const voPath = (service: string, namespace: string): string => {
  const path = nsToPath(namespace);
  const serviceNames = names(service);
  return `services/${serviceNames.fileName}/src/read-model/types${path}`;
}

export const voImportFromDefinitionId = (id: string): string => {
  return '@app/' + id.replace('/definitions/', '');
}

