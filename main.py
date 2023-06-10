from os import getenv
import discord
from discord.ext import commands,tasks

from dotenv import load_dotenv
load_dotenv()

from blogReader import APIChecker, msg_new_article, build_embed

BOT_TOKEN = getenv('BOT_TOKEN')
CHANNEL_ID = getenv('CHANNEL_ID')

# LOG_LEVEL can either be an int or a string
LOG_LEVEL = getenv('LOG_LEVEL')
if LOG_LEVEL.isnumeric():
    LOG_LEVEL = int(LOG_LEVEL)

discord.utils.setup_logging(root=True, level=LOG_LEVEL)

apc = APIChecker()

REFRESH_DELAY = int(getenv('REFRESH_DELAY')) #in minutes

intent = discord.Intents.default()
intent.message_content = True

bot = commands.Bot(command_prefix = '!', intents = intent)

channel_notify = [0]

@bot.event
async def on_ready():
    channel_notify[0] = await bot.fetch_channel(CHANNEL_ID)
    auto_send.start()

@tasks.loop(minutes=REFRESH_DELAY)
async def auto_send():
    new = apc.checkUpdate()
    for a in new:
        await channel_notify[0].send(msg_new_article(a), embed=build_embed(a))


if __name__ == "__main__":
    try:
        bot.run(BOT_TOKEN, log_handler=None) # Setting log_handler to None allows
                                             # to propagate the handler to root for processing.
    except discord.errors.LoginFailure:
        print("Invalid discord token")
        exit(1)

