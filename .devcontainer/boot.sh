#!/usr/bin/env zsh
set -e
bundle
bundle exec rake db:migrate
bundle exec rake db:seed
bundle exec rails dev:cache
exec "$@"
