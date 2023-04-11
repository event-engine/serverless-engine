import type { Environment } from './environment.types';

export const env: Environment = {
  name: 'dev',
  region: 'eu-west-1',
  profile: 'local',
  keycloak: {
    baseUrl: 'http://localhost:8080',
    realm: 'app'
  },
  postgres: {
    host: 'localhost',
    port: 5432,
    database: 'app',
    user: 'dev',
    password: 'dev',
    max: 200
  },
  eventStore: {
    adapter: "postgres"
  },
  documentStore: {
    adapter: "postgres"
  },
  authentication: {
    disabled: true
  }
};
