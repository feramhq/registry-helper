#!/bin/sh
set -e

while true
do
  echo [$(date)] Updating services
  # Set AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY environment variables
  eval "$(aws ecr get-login --no-include-email --region us-east-1)"
  echo Using aws access key id: $(aws configure get aws_access_key_id)
  docker service ls -q | xargs -n 1 docker service update --with-registry-auth --detach
  echo Update finished

  touch /heartbeat

  # Sleep for 6h
  sleep 21600
done
