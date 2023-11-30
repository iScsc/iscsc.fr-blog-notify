# iscsc.fr-blog-notify

Bot to notify on Discord that a new article has been created on the club website.

## How to

I wrote a simple tutorial on the basics to make a similar bot on the [iscsc website](https://iscsc.fr/blog/638fdec624bc362fff7a2d18), feel free to check it out!

## Config
*see [.env.example](./.env.example)*

In a `.env` file, specify your Discord token and the channel ID in which the bot needs to post notifications. You can also chose the refresh delay, in minutes.

URLs to both the API and the blog posts need to be specified in the `.env` too, and you can also chose the color of the embed banner but there is a default value in `blogReader.py`. For the club website, we have the following URLs:

```
BLOG_URL='https://iscsc.fr/blog'
API_URL='https://iscsc.fr/api/articles'
```

You can also configure a `LOG_FILE` environment variable, it must be a path to a file.  
The logs will output to both stdout and this file, if empty or not defined the logs will only output to stdout.  
> If it doesn't exist it will be created, if the bot is ran in the docker container the file will be shared with the host as a mounted volume in the container.

## Start the bot
### Directly on host system
To run it on the host system simply run `python3 main.py`.

:warning: but you **should really** consider using the [containerized deployment](#Containerized-with-Docker).

### Containerized with Docker
The bot can run in Docker thanks to the provided `Dockerfile`. To start the bot in Docker, you just have to run `./run.sh`: the script cleans previous running containers, builds the current one and starts it.

Once the command is finished, simply run `docker ps` to check that the bot is indeed running, if you can't see a `iscsc.fr-notify-bot:latest` container running check the [debug section](#Debug).

#### Debug
If the container isn't running after `./run.sh` it has probably crashed due to an error, first check that you well set up the required variables, described in the [config section](#Config).  
After re-running `./run.sh` if the container is still not running try to start it with the last line of `run.sh` (`docker run...`) **removing `--detach`**, you'll get the output in your terminal and will be able to debug the bot.  
Also, feel free to contact any of the maintainer or open an issue if needed.