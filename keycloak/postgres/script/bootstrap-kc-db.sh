#!/bin/sh

set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
	CREATE USER ${KEYCLOAK_USER} PASSWORD '${KEYCLOAK_PASSWORD}';
	CREATE DATABASE ${KEYCLOAK_DB} WITH ENCODING 'UTF8';
	GRANT ALL PRIVILEGES ON DATABASE ${KEYCLOAK_DB} TO ${KEYCLOAK_USER};
EOSQL
