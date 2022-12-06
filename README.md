# iscsc.fr-blog-notify

Bot to notify on Discord that a new article has been created on the club website.

## Config

In `main.py`, specify your Discord token and the channel ID in which the bot needs to post notifications. You can also chose the refresh timer, in minutes.

URLs to both the API and the blog posts need to be specified in `blogReader.py`, and you can also chose the color of the embed banner in the same file. For the club website, we have the following URLs:

```python
BLOG_URL = "https://iscsc.fr/blog"
API_URL = "https://iscsc.fr/api/articles"
```
