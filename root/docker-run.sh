#!/usr/bin/env bash

set -e

if [ "${SERVER_NAME}" == "example.com" ]; then
  echo "---------------------------------------------" >&2
  echo "Server name is set to example.com!" >&2
  echo "You should use this only for testing purpose!" >&2
  echo "---------------------------------------------" >&2
  sleep 5
fi

cd /config

if [ ! -f /config/homeserver.yaml ]; then
  python -m synapse.app.homeserver \
    --server-name ${SERVER_NAME} \
    --config-path homeserver.yaml \
    --generate-config \
    --report-stats=${REPORT_STATS}
fi

exec python -m synapse.app.homeserver --config-path homeserver.yaml
