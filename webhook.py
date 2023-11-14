from os import getenv

import discord
import requests

EMBED_COLOR = int(getenv('EMBED_COLOR') or "0xffb7c5", base=16)
WEBHOOK_URL = getenv('WEBHOOK_URL')

def build_embed(article):
    return discord.Embed(title=article['title'], url=article['url'],description=article['summary'], color=EMBED_COLOR)

def msg_new_article(article):
    return f"Nouveau post de {article['author']}!"

def notify(article):
    session = requests.Session()
    webhook = discord.webhook.SyncWebhook.from_url(WEBHOOK_URL, session=session)

    webhook.send(msg_new_article(article), embed=build_embed(article))
