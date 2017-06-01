#!/bin/bash

# Client registration
if [ -n "$KEYCLOAK_INITIAL_ACCESS_TOKEN" ] && [ -n "$KEYCLOAK_AUTH_SERVER_URL" ] && [ -n "$KEYCLOAK_REALM" ] && [ -n "$KEYCLOAK_RESOURCE" ]
then
  echo "trying to configure keycloak-cli"
  /keycloak/bin/kcreg.sh config initial-token $KEYCLOAK_INITIAL_ACCESS_TOKEN --server $KEYCLOAK_AUTH_SERVER_URL --realm $KEYCLOAK_REALM

  echo "trying to create cli"
  /keycloak/bin/kcreg.sh create -s clientId=$KEYCLOAK_RESOURCE -s protocol=openid-connect -s rootUrl=/$KEYCLOAK_RESOURCE
fi

exec "$@"