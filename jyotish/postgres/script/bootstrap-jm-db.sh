#!/bin/sh

set -e

psql -v ON_ERROR_STOP=1 --username "${POSTGRES_USER}" --dbname "${POSTGRES_DB}" <<-EOSQL
	CREATE USER ${JYOTISH_USER} PASSWORD '${JYOTISH_PASSWORD}';
	CREATE DATABASE ${JYOTISH_DB} WITH ENCODING 'UTF8';
	GRANT ALL PRIVILEGES ON DATABASE ${JYOTISH_DB} TO ${JYOTISH_USER};
EOSQL

psql -v ON_ERROR_STOP=1 --username "${JYOTISH_USER}" --dbname "${JYOTISH_DB}" <<-EOSQL
	CREATE TYPE language AS ENUM ('en', 'hi');
	CREATE TABLE users (
		email text PRIMARY KEY,
		name text NOT NULL,
		lang language DEFAULT 'en',
		description text NOT NULL DEFAULT '',
		astrologer boolean DEFAULT false,
		public boolean DEFAULT true
	);
EOSQL
