import {FilterProcessor} from "@app/infrastructure/DocumentStore/FilterProcessor";

export interface Filter {
    processWith: (processor: FilterProcessor) => any;
}

