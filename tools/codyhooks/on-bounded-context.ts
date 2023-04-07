import {CodyHook, CodyResponse, CodyResponseType, Node} from "@proophboard/cody-types";
import {Context} from "./context";
import {nodeNameToPascalCase} from "@proophboard/cody-utils";
import {execGenerator, makeNxCmd} from "./exec-generator";
import {logger} from "@nrwl/devkit";

export const onBoundedContext: CodyHook<Context> = async (bc: Node, ctx: Context): Promise<CodyResponse> => {
  const serviceName = nodeNameToPascalCase(bc);

  try {
    const output = execGenerator('service', serviceName);

    return {
      type: CodyResponseType.Info,
      cody: `Created a service for bounded context ${bc.getName()}`,
      details: output
    }
  } catch (e) {
    logger.error(e);
    return {
      type: CodyResponseType.Error,
      cody: `Couldn't create service for Bounded Context ${bc.getName()}.`,
      details: `Failed to execute: ` + makeNxCmd('service', serviceName),
    }
  }
}
