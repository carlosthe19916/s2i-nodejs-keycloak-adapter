#!/bin/bash

# Client registration
if [ -n "$KEYCLOAK_INITIAL_ACCESS_TOKEN" ] && [ -n "$KEYCLOAK_AUTH_SERVER_URL" ] && [ -n "$KEYCLOAK_REALM" ] && [ -n "$KEYCLOAK_RESOURCE" ]
then
  echo "trying to configure keycloak-cli"
  /opt/app-root/etc/keycloak/bin/kcreg.sh config initial-token $KEYCLOAK_INITIAL_ACCESS_TOKEN --server $KEYCLOAK_AUTH_SERVER_URL --realm $KEYCLOAK_REALM

  echo "trying to create cli"
  /opt/app-root/etc/keycloak/bin/kcreg.sh create -s clientId=$KEYCLOAK_RESOURCE -s protocol=openid-connect -s rootUrl=/$KEYCLOAK_RESOURCE

  if [ -n "$KEYCLOAK_WEB_ORIGIN" ]
  then
    export KEYCLOAK_WEB_ORIGIN=${KEYCLOAK_WEB_ORIGIN%/*}

    echo "trying to update cli"
    /opt/app-root/etc/keycloak/bin/kcreg.sh create -s clientId=$KEYCLOAK_RESOURCE -s protocol=openid-connect -s rootUrl=/$KEYCLOAK_RESOURCE
    
    echo "adding redirect uris" 
    /opt/app-root/etc/keycloak/bin/kcreg.sh update $KEYCLOAK_RESOURCE -s 'redirectUris=["$KEYCLOAK_WEB_ORIGIN/*"]'

    echo "adding web origins"
    /opt/app-root/etc/keycloak/bin/kcreg.sh update $KEYCLOAK_RESOURCE -s 'webOrigins=["$KEYCLOAK_WEB_ORIGIN"]'
  fi
fi

exec "$@"
