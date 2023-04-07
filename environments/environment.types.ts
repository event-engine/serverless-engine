import {PoolConfig} from "pg";

export interface Environment {
  name: 'dev' | 'stg' | 'prod';
  region: string;
  profile: string;
  postgres: PoolConfig;
  keycloak: {baseUrl: string, realm: string};
  eventStore: {
    adapter: "postgres" | "memory"
  },
  documentStore: {
    adapter: "postgres" | "memory"
  },
  authentication?: {
    disabled: boolean;
  }
}
