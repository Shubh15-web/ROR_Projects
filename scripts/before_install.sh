#!/bin/bash
set -e
pkill -f puma || true
rm -rf /var/www/rails-app
mkdir -p /var/www/rails-app
