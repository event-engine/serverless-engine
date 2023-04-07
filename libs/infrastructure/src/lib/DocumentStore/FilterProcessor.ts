import {EqFilter} from "@app/infrastructure/DocumentStore/Filter/EqFilter";
import {AnyFilter} from "@app/infrastructure/DocumentStore/Filter/AnyFilter";
import {AndFilter} from "@app/infrastructure/DocumentStore/Filter/AndFilter";
import {Filter} from "@app/infrastructure/DocumentStore/Filter";
import {OrFilter} from "@app/infrastructure/DocumentStore/Filter/OrFilter";
import {DocIdFilter} from "@app/infrastructure/DocumentStore/Filter/DocIdFilter";
import {ExistsFilter} from "@app/infrastructure/DocumentStore/Filter/ExistsFilter";
import {GtFilter} from "@app/infrastructure/DocumentStore/Filter/GtFilter";
import {GteFilter} from "@app/infrastructure/DocumentStore/Filter/GteFilter";
import {LtFilter} from "@app/infrastructure/DocumentStore/Filter/LtFilter";
import {LteFilter} from "@app/infrastructure/DocumentStore/Filter/LteFilter";
import {InArrayFilter} from "@app/infrastructure/DocumentStore/Filter/InArrayFilter";
import {LikeFilter} from "@app/infrastructure/DocumentStore/Filter/LikeFilter";
import {NotFilter} from "@app/infrastructure/DocumentStore/Filter/NotFilter";
import {AnyOfDocIdFilter} from "@app/infrastructure/DocumentStore/Filter/AnyOfDocIdFilter";
import {AnyOfFilter} from "@app/infrastructure/DocumentStore/Filter/AnyOfFilter";

export interface FilterProcessor {
  process: (filter: Filter) => any;
  processAnyFilter: (filter: AnyFilter) => any;
  processEqFilter: (filter: EqFilter) => any;
  processAndFilter: (filter: AndFilter) => any;
  processOrFilter: (filter: OrFilter) => any;
  processDocIdFilter: (filter: DocIdFilter) => any;
  processExistsFilter: (filter: ExistsFilter) => any;
  processGtFilter: (filter: GtFilter) => any;
  processGteFilter: (filter: GteFilter) => any;
  processLtFilter: (filter: LtFilter) => any;
  processLteFilter: (filter: LteFilter) => any;
  processInArrayFilter: (filter: InArrayFilter) => any;
  processLikeFilter: (filter: LikeFilter) => any;
  processNotFilter: (filter: NotFilter) => any;
  processAnyOfDocIdFilter: (filter: AnyOfDocIdFilter) => any;
  processAnyOfFilter: (filter: AnyOfFilter) => any;
}
