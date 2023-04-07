import {Filter} from "@app/infrastructure/DocumentStore/Filter";
import {FilterProcessor} from "@app/infrastructure/DocumentStore/FilterProcessor";

export class DocIdFilter implements Filter {
  public readonly val: any;

  constructor(val: any) {
    this.val = val;
  }

  processWith(processor: FilterProcessor): any {
    return processor.processDocIdFilter(this);
  }
}
