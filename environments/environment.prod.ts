import type { Environment } from './environment.types';

export const env: Environment = {
  name: 'prod',
  profile: '',
  keycloak: {
    baseUrl: '',
    realm: 'app'
  },
  postgres: {
  },
  region: 'eu-west-1',
  eventStore: {
    adapter: "postgres"
  },
  documentStore: {
    adapter: "postgres"
  }
};
