#!/bin/bash

until curl --silent http://couchdb:5984/ | grep Welcome; do
  >&2 echo "Couchdb is unavailable - sleeping"
  sleep 1
done

>&2 echo "Couchdb is available"



printenv | sed 's/^\(.*\)$/export \1/g' > /env.sh

service cron start
echo "started services"

node /git/flavor-builder/node_modules/visualizer-on-tabs/bin/build.js --outDir=/var/www/html/on-tabs/ --config=/on-tabs-config.json

tail -f /var/log/cron.log
