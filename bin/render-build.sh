#!/usr/bin/env bash
# exit on error
set -o errexit
bundle install
echo doing rails assets:precompile
bundle exec rails assets:precompile

echo doing exec rails assets:clean
bundle exec rails assets:clean

echo doing DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rails db:migrate:reset
DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rails db:migrate:reset

# tanaka add db:migrate
echo doing rails db:drop db:create db:migrate
bundle rails db:drop db:create db:migrate

# bundle exec rails db:migrate
echo doing rails db:seed
bundle exec rails db:seed
