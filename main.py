import discord
from blogReader import APIChecker, msg_new_article, build_embed

from discord.ext import commands,tasks

BOT_TOKEN = ''
CHANNEL_ID = ''

apc = APIChecker()

REFRESH_TIME = 10 #in minutes

intent = discord.Intents.default()
intent.message_content = True

bot = commands.Bot(command_prefix = '!', intents = intent)

channel_notify = [0]

@bot.event
async def on_ready():
    channel_notify[0] = await bot.fetch_channel(CHANNEL_ID)
    auto_send.start()

@tasks.loop(minutes=REFRESH_TIME)
async def auto_send():
    new = apc.checkUpdate()
    for a in new:
        await channel_notify[0].send(msg_new_article(a), embed=build_embed(a))


if __name__ == "__main__":
    try:
        bot.run(BOT_TOKEN)
    except discord.errors.LoginFailure:
        print("Invalid discord token")
        exit(1)

