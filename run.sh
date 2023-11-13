#!/bin/sh

PATH=$(/usr/bin/getconf PATH || /bin/kill $$)
NAME="iscscfr-blog-bot"

docker container rm ${NAME}
docker build -t ${NAME} .
docker run --interactive --tty \
    -p 5000:5000 \
    --volume .:/opt/blog_bot \
    --name ${NAME} \
    ${NAME}:latest
