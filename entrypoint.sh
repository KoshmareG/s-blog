#!/bin/bash
set -e

rm -f /music_service/tmp/pids/server.pid

bundle install

exec "$@"
