# iscsc.fr-blog-notify

Bot to notify on Discord that a new article has been created on the club website.

## How to

I wrote a simple tutorial on the basics to make a similar bot on the [iscsc website](https://iscsc.fr/blog/638fdec624bc362fff7a2d18), feel free to check it out!

## Config

In `main.py`, specify your Discord token and the channel ID in which the bot needs to post notifications. You can also chose the refresh timer, in minutes.

URLs to both the API and the blog posts need to be specified in `blogReader.py`, and you can also chose the color of the embed banner in the same file. For the club website, we have the following URLs:

```python
BLOG_URL = "https://iscsc.fr/blog"
API_URL = "https://iscsc.fr/api/articles"
```

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