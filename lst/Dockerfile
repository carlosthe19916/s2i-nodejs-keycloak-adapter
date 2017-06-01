FROM ryanj/centos7-s2i-nodejs:lts

# Keycloak Client
ADD kcreg.sh /keycloak/bin
RUN mkdir -p /keycloak/bin/client && \
    curl -L -o /keycloak/bin/client/keycloak-client-registration-cli.jar http://central.maven.org/maven2/org/keycloak/keycloak-client-registration-cli/3.0.0.Final/keycloak-client-registration-cli-3.0.0.Final.jar

ADD keycloak-entrypoint.sh /keycloak
ENTRYPOINT [ "/keycloak/keycloak-entrypoint.sh" ]