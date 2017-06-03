FROM carlosthe19916/centos7-s2i-angular-cli

USER root

# Install Java
RUN INSTALL_PKGS="java-1.8.0-openjdk java-1.8.0-openjdk-devel" && \
    yum install -y --enablerepo=centosplus $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    yum clean all -y

# Keycloak Client
RUN mkdir -p /opt/app-root/etc/keycloak/bin/client/
ADD kcreg.sh /opt/app-root/etc/keycloak/bin
RUN curl -L -o /opt/app-root/etc/keycloak/bin/client/keycloak-client-registration-cli.jar http://central.maven.org/maven2/org/keycloak/keycloak-client-registration-cli/3.0.0.Final/keycloak-client-registration-cli-3.0.0.Final.jar

USER 1001

ADD keycloak-entrypoint.sh /opt/app-root/etc/keycloak
ENTRYPOINT [ "/opt/app-root/etc/keycloak/keycloak-entrypoint.sh" ]