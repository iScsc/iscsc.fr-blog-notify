# iscsc.fr-blog-notify

Bot to notify on Discord that a new article has been created on the club website.

## How to

It's actually a flask app waiting for request and using a webhook to write on a Discord server.

> and so it is quite different than the `bot1.0` we had before! (which was a real discord bot, not a hook)

## Config
*see [.env.example](./.env.example)*

In a `.env` file, specify your Discord webhook URL the bot needs to post notifications. You should also specify the port on which the flask app will listen.

## Start the bot
**DISCLAIMER:** if you happen to run this bot in production, you're doing it at your own risk, without any warranty of security, isolation or behavior.
Especially if you

### Directly on host system (for development only!!)
To run it on the host system simply run `python3 main.py` (you'll need all the dependencies in `requirements.txt`)

:warning: but you **should really** consider using the [containerized deployment](#Containerized-with-Docker).  
:warning::warning: this is **exclusively** for development, to run in production see the section below. 

### Containerized with Docker
#### Production mode
The bot can run in Docker thanks to the provided `Dockerfile`. To start the bot in Docker, you just have to run `./run.sh prod`: the script cleans previous running containers, builds the current one and starts it.

> Note: it's mandatory to use this `./run.sh prod` in production because the default flask server [**isn't safe**](https://flask.palletsprojects.com/en/2.3.x/server/).  
> See [Deploying in production](https://flask.palletsprojects.com/en/2.3.x/deploying/).

Once the command is finished, simply run `docker ps -a` to check that the bot is indeed running **and** `STATUS: Up`, if you can't see a `iscscfr-blog-bot:latest` or the container is `STATUS: Exited`, check the logs with `docker logs iscscfr-blog-bot`.

#### Development and debug
Simply run `./run.sh` (without `prod`) and you'll be in the docker environment.  
Then just start the bot as you would do on the host: `python3 main.py`.

> Note: you can also test the production server in this environment using `gunicorn -w 1 -b 0.0.0.0:5000 --access-logfile=- main:app`
