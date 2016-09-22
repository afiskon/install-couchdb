#!/bin/sh

set -e

cd apache-couchdb-2.0.0/

sudo sv stop couchdb
sudo killall epmd || true
sudo rm -rf /home/couchdb

sudo cp -R rel/couchdb /home/couchdb
sudo chown -R couchdb:couchdb /home/couchdb
sudo find /home/couchdb -type d -exec chmod 0770 {} \;
sudo sh -c 'chmod 0644 /home/couchdb/etc/*'

sudo sv start couchdb
sleep 3
curl -X GET http://localhost:5984/_membership
