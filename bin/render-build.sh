#!/usr/bin/env bash
# exit on error
set -o errexit
echo $SCHEMA_NAME

bundle install
echo doing rails assets:precompile
bundle exec rails assets:precompile

echo doing exec rails assets:clean
bundle exec rails assets:clean

echo doing DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rails db:drop db:create
DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rails db:drop db:create

# oda add schema create
# 環境変数 SCHEMA_NAME を確認
if [ -z "$SCHEMA_NAME" ]; then
  echo "SCHEMA_NAME is not set."
  exit 1
fi
# スキーマを作成
psql -d データベース名 -c "CREATE SCHEMA IF NOT EXISTS $SCHEMA_NAME;"

# tanaka add db:migrate
echo doing rails db:migrate
bundle exec rails db:migrate

# bundle exec rails db:migrate
echo doing rails db:seed
bundle exec rails db:seed
