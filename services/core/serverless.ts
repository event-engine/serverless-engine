import { env } from '../../environments/environment.serverless';
import type { Serverless } from 'serverless/aws';
import { baseServerlessConfigProvider } from '../../serverless.base';

const serverlessConfig: Partial<Serverless> = {
  provider: baseServerlessConfigProvider,
  plugins: ['serverless-localstack'],
  service: 'core',
  custom: {
    localstack: {
      stages: ['dev'],
      lambda: {
        mountCode: 'True',
      },
    }
  },
  resources: {
    Resources: {
      AppApiGW: {
        Type: 'AWS::ApiGateway::RestApi',
        Properties: {
          Name: `${env.name}-AppApiGW`,
        },
      },
    },
    Outputs: {
      ApiGatewayRestApiId: {
        Value: {
          Ref: 'AppApiGW',
        },
        Export: {
          Name: `${env.name}-AppApiGW-restApiId`,
        },
      },
      ApiGatewayRestApiRootResourceId: {
        Value: {
          'Fn::GetAtt': ['AppApiGW', 'RootResourceId'],
        },
        Export: {
          Name: `${env.name}-AppApiGW-rootResourceId`,
        },
      },
    },
  },
};

module.exports = serverlessConfig;
