FROM carlosthe19916/centos7-s2i-angular-cli

# Keycloak Client
ADD kcreg.sh /opt/app-root/etc/keycloak
RUN curl -L -o /opt/app-root/etc/keycloak/bin/client/keycloak-client-registration-cli.jar http://central.maven.org/maven2/org/keycloak/keycloak-client-registration-cli/3.0.0.Final/keycloak-client-registration-cli-3.0.0.Final.jar

ADD keycloak-entrypoint.sh /opt/app-root/etc/keycloak
ENTRYPOINT [ "/opt/app-root/etc/keycloak/keycloak-entrypoint.sh" ]