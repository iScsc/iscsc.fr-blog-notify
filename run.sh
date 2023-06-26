#!/bin/sh

#add environmental variable of .env to the bash script
. ./.env

#Define absolute path for the host and the serv from the relative common path
HOST_LOG_FILE=$(realpath -P ${LOG_FILE})
SERV_LOG_FILE=/opt/iscsc.fr-notify-bot${LOG_FILE}

PATH=$(/usr/bin/getconf PATH || /bin/kill $$)
NAME="iscsc.fr-notify-bot"

RED=$(tput setaf 1)
NORMAL=$(tput sgr0)

# TODO: get LOG_FILE from .env and if it is empty remove the sudo and the warning

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
    --volume ${HOST_LOG_FILE}:${SERV_LOG_FILE} \
    ${NAME}:latest
