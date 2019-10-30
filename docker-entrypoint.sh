#!/bin/bash

# required by docker
set -e

# file_env VAR [DEFAULT]
# a common function used for reading environment variables
# taken from: https://github.com/docker-library/postgres/blob/master/12/docker-entrypoint.sh#L9
file_env() {
  local var="$1"
  local fileVar="${var}_FILE"
  local def="${2:-}"
  if [ "${!var:-}" ] && [ "${!fileVar:-}" ]; then
    echo >&2 "Error: Both $var and $fileVar are set (but are exclusive)."
    exit 1
  fi
  local val="$def"
  if [ "${!var:-}" ]; then
    val="${!var}"
  elif [ "${!fileVar:-}" ]; then
    val="$(< "${!fileVar}")"
  fi
  export "$var"="$val"
  unset "$fileVar"
}

# setup the enviroment variables
file_env 'CONFIG_DATABASE_FILEPATH'

# check if the drawpile database already exists
if [ ! -e "$CONFIG_DATABASE_FILEPATH" ]; then
  # if it does not exist, run the database initialization scripts
  echo 'Beginning database initialization...'
  for f in /docker-entrypoint/*.sql; do
    echo "Running $f on $CONFIG_DATABASE_FILEPATH"
    sqlite3 "$CONFIG_DATABASE_FILEPATH" < $f
  done
fi

# required by docker
exec "$@"
