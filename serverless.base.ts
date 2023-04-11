import type { Serverless } from 'serverless/aws';
import { env, envName } from './environments/environment.serverless';

console.log(`-------------- USING ENV: ${env.name} ----------------`);

export const baseServerlessConfigProvider: Serverless['provider'] = {
  name: 'aws',
  runtime: 'nodejs16.x',
  memorySize: 128,
  profile: env.profile,
  stage: env.name,
  environment: {
    NODE_ENV: envName,
    AWS_NODEJS_CONNECTION_REUSE_ENABLED: '1',
    DB_PASSWORD: process.env['DB_PASSWORD'],
  },
  region: env.region,
};

export const baseServerlessConfig: Partial<Serverless> = {
  frameworkVersion: '3',
  service: 'base',
  package: {
    individually: true,
    excludeDevDependencies: true
  },
  plugins: ['serverless-esbuild', 'serverless-offline', 'serverless-lift'],
  custom: {
    esbuild: {
      bundle: true,
      minify: env.name !== 'dev',
      target: ['es2020'],
      sourcemap: env.name !== 'dev',
      sourcesContent: false,
      plugins: '../../plugins.js',
      define: { 'require.resolve': undefined },
      exclude: ["pg-native"],
      external: ["pg-native"]
    },
    localstack: {
      stages: ["dev"]
    }
  },
  provider: {
    ...baseServerlessConfigProvider,
    apiGateway: {
      minimumCompressionSize: 1024,
      // @ts-ignore
      restApiId: {
        'Fn::ImportValue': `${env.name}-AppApiGW-restApiId`,
      },
      // @ts-ignore
      restApiRootResourceId: {
        'Fn::ImportValue': `${env.name}-AppApiGW-rootResourceId`,
      },
    },
  },
};
