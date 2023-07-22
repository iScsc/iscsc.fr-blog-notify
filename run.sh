#!/bin/sh

# import environment variable from the .env to the bash script
. ./.env

# Define absolute path for log file in the host
[ -z "${LOG_FILE}" ] && { echo "LOG_FILE not defined in .env"; exit 1; }
HOST_LOG_FILE=$(realpath -P ${LOG_FILE})

PATH=$(/usr/bin/getconf PATH || /bin/kill $$)
NAME="iscsc.fr-notify-bot"

RED=$(tput setaf 1)
NORMAL=$(tput sgr0)

# Creating the file and setting the right permissions:
if [ -f "${HOST_LOG_FILE}" ]; then
    echo "$HOST_LOG_FILE already exist, take care the root group can read it in the following line !!!"
    ls -l ${HOST_LOG_FILE}
else
    touch $HOST_LOG_FILE
    chmod 664 $HOST_LOG_FILE
    sudo chown :root $HOST_LOG_FILE
fi

# TODO: don't run the command if there is nothinf to stop
docker stop $(docker ps --all --quiet --filter ancestor=${NAME} --format="{{.ID}}")

docker build -t ${NAME} .
echo "${RED}[!]${NORMAL} the log file (mounted in the container) group must match with one of the groups of the user in the container"
docker run --detach --rm --interactive --tty \
    --name ${NAME} \
    --volume ${HOST_LOG_FILE}:/opt/iscsc.fr-notify-bot/${LOG_FILE} \
    ${NAME}:latest
