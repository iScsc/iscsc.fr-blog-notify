from os import getenv, path
import logging
import discord
from discord.ext import commands,tasks

from dotenv import load_dotenv
load_dotenv()

from blogReader import APIChecker, msg_new_article, build_embed

# Set up global variables
BOT_TOKEN = getenv('BOT_TOKEN')
CHANNEL_ID = getenv('CHANNEL_ID')
REFRESH_DELAY = int(getenv('REFRESH_DELAY')) #in minutes

# LOG_LEVEL can either be an int or a string
LOG_LEVEL = getenv('LOG_LEVEL')
if LOG_LEVEL.isnumeric():
    LOG_LEVEL = int(LOG_LEVEL)

# Set up logging
discord.utils.setup_logging(root=True, level=LOG_LEVEL)

def log2file_handler():
    log_file = getenv('LOG_FILE')
    if not log_file:
        return None

    logs_dir = path.dirname(log_file)
    if not path.exists(logs_dir) or path.isfile(logs_dir):
        logging.error("base directory of '%s' : '%s' doesn't exists or is a file.", log_file, logs_dir)
        logging.error("won't log to '%s'", log_file)
        return None

    return logging.FileHandler(log_file, mode='a')

file_handler = log2file_handler()
if file_handler is not None:
    discord.utils.setup_logging(handler=file_handler, root=True, level=logging.INFO)
    logging.info("FileHandler added to root logger it will write to '%s'", file_handler.stream.name)

# Set up the API checker object
apc = APIChecker()


# Set up the discord bot and its event and loop
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

