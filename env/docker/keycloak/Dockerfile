FROM quay.io/keycloak/keycloak:17.0.1

COPY conf /opt/keycloak/conf

#ADD ./themes /opt/keycloak/themes

RUN /opt/keycloak/bin/kc.sh build

WORKDIR /opt/keycloak

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]

## use for development
CMD ["start-dev"]

## use for production
#CMD ["start"]
