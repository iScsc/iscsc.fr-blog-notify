#!/bin/sh

# import environment variable from the .env to the bash script
. ./.env

# Define absolute path for log file in the host
[ -z "${LOG_FILE}" ] && { echo "${RED}[!]${NORMAL} LOG_FILE not defined in .env"; exit 1; }
HOST_LOG_FILE=$(realpath -P ${LOG_FILE})

PATH=$(/usr/bin/getconf PATH || /bin/kill $$)
NAME="iscsc.fr-notify-bot"

RED=$(tput setaf 1)
NORMAL=$(tput sgr0)

# Creating the file and setting the right permissions:
if [ -f "${HOST_LOG_FILE}" ]; then
    echo "${RED}[!]${NORMAL} $HOST_LOG_FILE already exists, take care that the ${RED}root group${NORMAL} can read it:"
    ls -l ${HOST_LOG_FILE}
else
    touch $HOST_LOG_FILE || { echo "${RED}[!]${NORMAL} Couldn't create '$HOST_LOG_FILE', maybe a parent directoy is missing?"; exit 1; }
    chmod 664 $HOST_LOG_FILE
    sudo chown :root $HOST_LOG_FILE
fi

# Stop old containers if any
OLD_CONTAINERS=$(docker ps --all --quiet --filter ancestor=${NAME} --format="{{.ID}}")
[ ! -z "$OLD_CONTAINERS" ] && docker stop $OLD_CONTAINERS

docker build -t ${NAME} .
echo "${RED}[!]${NORMAL} the log file (mounted in the container) group must match with one of the groups of the user in the container"
docker run --detach --rm --interactive --tty \
    --name ${NAME} \
    --volume ${HOST_LOG_FILE}:/opt/iscsc.fr-notify-bot/${LOG_FILE} \
    ${NAME}:latest
