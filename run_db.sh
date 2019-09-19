#!/usr/bin/env bash
DB_CONTAINER_NAME='stickers_management_dev_db'

# if container already exists, start it.
# else create new container.
docker start $DB_CONTAINER_NAME > /dev/null 2>&1 || \
  ( echo "Creating new container for local tests ..."
    docker run --name $DB_CONTAINER_NAME \
   -e POSTGRES_USER=stickers_management \
   -e POSTGRES_PASSWORD='StickersManagement!23' \
   -d \
   -p 5432:5432 \
    postgres:alpine && sleep 5)

# Development database
RAILS_ENV=development rails db:create
RAILS_ENV=development rails db:migrate
RAILS_ENV=development rails db:seed
RAILS_ENV=development rails data:migrate

# Test database
RAILS_ENV=test rails db:test:prepare
