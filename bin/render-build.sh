#!/usr/bin/env bash
# exit on error
set -o errexit
echo $SCHEMA_NAME

bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean
DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rails db:drop db:create
# a2308 add schema create 
psql $DATABASE_URL -c "CREATE SCHEMA IF NOT EXISTS $SCHEMA_NAME;"
# tanaka add db:migrate
bundle exec rails db:migrate
# bundle exec rails db:migrate
bundle exec rails db:seed
