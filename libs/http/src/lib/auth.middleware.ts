import middy from '@middy/core';
import { APIGatewayProxyEvent, APIGatewayProxyResult } from 'aws-lambda';
import jwt from 'jsonwebtoken';
import {httpError} from './response';
import { Handler, UserContext } from './types';
import fetch from "node-fetch";
import jwkToBuffer, {JWK} from "jwk-to-pem";

export interface KeycloakConfig {
  baseUrl: string;
  realm: string;
}

let PEM: string;

type KeycloakJWK = JWK & {alg: string};

const loadPEM = async (kcConfig: KeycloakConfig): Promise<string> => {
  if(!PEM) {
    const res = await fetch(kcConfig.baseUrl + '/auth/realms/' + kcConfig.realm + '/protocol/openid-connect/certs');
    const certs = await res.json() as {keys: KeycloakJWK[]};
    const filteredCerts = certs.keys.filter(key => key.alg === 'RS256');
    if(filteredCerts.length === 0) {
      throw new Error("No public key returned by Keycloak with property 'alg' set to RS256");
    }
    PEM = jwkToBuffer(filteredCerts[0]);
  }

  return PEM;
}

export function authMiddleware(kcConfig: KeycloakConfig, disabled?: boolean): middy.MiddlewareObj<
  Parameters<Handler<any>>[0],
  APIGatewayProxyResult
> {
  const before: middy.MiddlewareFn<
    APIGatewayProxyEvent,
    APIGatewayProxyResult
  > = async (request) => {
    if(disabled) {
      return Promise.resolve();
    }

    const authHeader = request.event.headers['Authorization'];

    if (authHeader) {
      const token = authHeader.split(' ')[1];

      try {
        const pem = await loadPEM(kcConfig);
        const data = jwt.verify(token, pem);
        (request.context as unknown as UserContext).user = {id: data.sub} as UserContext['user'];

        return Promise.resolve();
      } catch (error) {
        return httpError(error, { statusCode: 401 });
      }
    }

    return httpError('Missing token', { statusCode: 401 });
  };

  return {
    before,
  };
}
