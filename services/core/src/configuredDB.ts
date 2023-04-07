import {DB} from "@app/infrastructure/Postgres/DB";
import {Pool} from "pg";
import {env} from "@app/env";

let db: DB;

export const getConfiguredDB = (): DB => {
  if(!db) {
    db = new DB(new Pool(env.postgres))
  }

  return db;
}
