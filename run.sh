#!/bin/sh

# import environment variable from the .env to the bash script
. ./.env

# Define absolute path for log file in the host
HOST_LOG_FILE=$(realpath -P ${LOG_FILE})

PATH=$(/usr/bin/getconf PATH || /bin/kill $$)
NAME="iscsc.fr-notify-bot"

RED=$(tput setaf 1)
NORMAL=$(tput sgr0)

# Creating the file and setting the right permissions:

# TODO: test $? and exit if ==1
touch $HOST_LOG_FILE
chmod 664 $HOST_LOG_FILE
sudo chown :root $HOST_LOG_FILE

# TODO: don't run the command if there is nothinf to stop
docker stop $(docker ps --all --quiet --filter ancestor=${NAME} --format="{{.ID}}")

docker build -t ${NAME} .
echo "${RED}[!]${NORMAL} the log file (mounted in the container) owner must match the uid in the container"
docker run --detach --rm --interactive --tty \
    --name ${NAME} \
    --volume ${HOST_LOG_FILE}:/opt/iscsc.fr-notify-bot/${LOG_FILE} \
    ${NAME}:latest
