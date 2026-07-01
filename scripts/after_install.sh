#!/bin/bash
set -e
cd /var/www/rails-app
gem install bundler --no-document 2>/dev/null || true
bundle install --without development test
RAILS_ENV=production bundle exec rails db:migrate 2>/dev/null || true
RAILS_ENV=production bundle exec rails assets:precompile 2>/dev/null || true
