#!/bin/sh

PATH=$(/usr/bin/getconf PATH || /bin/kill $$)
NAME="iscsc.fr-notify-bot"

docker stop $(docker ps --all --quiet --filter ancestor=${NAME} --format="{{.ID}}")
docker build -t ${NAME} .
docker run --rm --interactive --tty --detach ${NAME}:latest
