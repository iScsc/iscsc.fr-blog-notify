#!/bin/sh

PATH=$(/usr/bin/getconf PATH || /bin/kill $$)
NAME="iscsc.fr-notify-bot"

RED=$(tput setaf 1)
NORMAL=$(tput sgr0)

# TODO: get LOG_FILE from .env and if it is empty remove the sudo and the warning
LOG_FILE='/tmp/test-logs.log'

# Hardcoded on purpose:
CONT_UID=2000

# Creating the file and setting the right permissions:

# TODO: test $? and exit if ==1
touch $LOG_FILE
chmod 664 $LOG_FILE
sudo chown root:${CONT_UID} $LOG_FILE

# TODO: don't run the command if there is nothinf to stop
docker stop $(docker ps --all --quiet --filter ancestor=${NAME} --format="{{.ID}}")

docker build -t ${NAME} .
echo "${RED}[!]${NORMAL} the log file (mounted in the container) owner must match the uid in the container"
docker run --rm --interactive --tty \
    --name ${NAME} \
    --user ${CONT_UID} \
    --volume ${LOG_FILE}:${LOG_FILE} \
    ${NAME}:latest
