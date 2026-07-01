#!/bin/bash
cd /var/www/rails-app

# Ensure directory is owned by ec2-user
sudo chown -R ec2-user:ec2-user /var/www/rails-app

# Install bundler
gem install bundler

# Configure bundle to avoid the .bundle permission issue
bundle config set --local without 'development test'
bundle config set --local path 'vendor/bundle'

# Install gems
bundle install
