#!/usr/bin/env bash
# exit on error
set -o errexit
bundle install
echo doing rails assets:precompile
bundle exec rails assets:precompile

echo doing exec rails assets:clean
bundle exec rails assets:clean

echo doing DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rails db:drop db:create
DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rails db:drop db:create

# tanaka add db:migrate
echo doing rails db:migrate
bundle exec rails db:migrate

# bundle exec rails db:migrate
echo doing rails db:seed
bundle exec rails db:seed
