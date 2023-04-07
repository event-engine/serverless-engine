import type { Environment } from './environment.types';

export const env: Environment = {
  name: 'stg',
  profile: '',
  keycloak: {
    baseUrl: '',
    realm: 'app'
  },
  postgres: {
    host: '',
    port: 5432,
    database: 'app',
    user: 'postgres',
    password: process.env['DB_PASSWORD'],
    max: 200
  },
  region: 'eu-central-1',
  eventStore: {
    adapter: "postgres"
  },
  documentStore: {
    adapter: "postgres"
  }
};
