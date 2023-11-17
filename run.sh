#!/bin/sh

PATH=$(/usr/bin/getconf PATH || /bin/kill $$)
NAME="iscscfr-blog-bot"

. .env
[ -z "$PORT" ] && { echo "Please configure PORT in .env first"; exit 1; }

DETACH=""
ENTRYPOINT=""
COMMAND=""
if [ "$1" = "prod" ]; then
    DETACH="--detach"
    ENTRYPOINT="--entrypoint python3"
    COMMAND="main.py"
fi

docker container rm ${NAME}
docker build -t ${NAME} .
docker run --interactive --tty \
    $DETACH \
    $ENTRYPOINT \
    -p $PORT:5000 \
    --volume .:/opt/blog_bot \
    --name ${NAME} \
    ${NAME}:latest \
    $COMMAND
