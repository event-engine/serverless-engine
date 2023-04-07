import {Filter} from "../Filter";
import {FilterProcessor} from "@app/infrastructure/DocumentStore/FilterProcessor";

export class AndFilter implements Filter {
    public readonly internalFilters: Filter[];

    constructor(aFilter: Filter, bFilter: Filter, ...otherFilters: Filter[]) {
        this.internalFilters = [aFilter, bFilter, ...otherFilters];
    }

    processWith(processor: FilterProcessor): any {
        return processor.processAndFilter(this);
    }
}
