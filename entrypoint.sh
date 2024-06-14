#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid

if [ "${RAILS_ENV}" = "production" ]
then
	echo "Production environment detected. Running production-specific tasks..."

  bundle install --without development test
  bundle exec rails assets:clobber
  bundle exec rails assets:precompile
  bundle exec rails db:migrate
fi

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"

