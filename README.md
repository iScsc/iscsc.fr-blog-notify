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
To run it on the host system simply `python3 main.py`.

**But** you really should containerize it thanks to the provided `Dockerfile`, you just have to run `./run.sh` the script clean previous running containers, build the current one and start it.
