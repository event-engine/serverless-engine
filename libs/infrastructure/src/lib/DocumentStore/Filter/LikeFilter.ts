import {Filter} from "../Filter";
import {getValueFromPath} from "../helpers";
import {FilterProcessor} from "@app/infrastructure/DocumentStore/FilterProcessor";

export class LikeFilter implements Filter {
    public readonly prop: string;
    public readonly val: any;

    constructor(prop: string, val: any) {
        this.prop = prop;
        this.val = val;
    }

    processWith(processor: FilterProcessor): any {
      return processor.processLikeFilter(this);
    }
}
