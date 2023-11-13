from os import getenv
import requests
from discord import Embed
import logging

BLOG_URL = getenv('BLOG_URL')
API_URL = getenv('API_URL')
EMBED_COLOR = int(getenv('EMBED_COLOR') or "0xffb7c5", base=16)

class APIChecker:

    def __init__(self) -> None:
        self.__cachedArticlesID = []
        self.url = API_URL
        self.__cache = []
        self.__new = []
        self.logger = logging.getLogger(__name__)
        self.logger.info("Bot initialisation.")
        #self.__getArticles()
        #self.__cacheArticlesID()
        self.logger.info("'cacheArticlesID' initialized")

    def __getArticles(self):
        if self.__cache == []:
            self.__cache = requests.get(self.url).json()
            return
        self.__new = requests.get(self.url).json()
        self.logger.info("'getArticles' request %s", self.url)
    
    def __cacheArticlesID(self):
        self.__cachedArticlesID = []
        for dic in self.__cache:
            self.__cachedArticlesID.append(dic['_id'])

    def recache(self):
        new_articles = self.checkUpdate()
        self.__cache = []
        self.__getArticles()
        self.__cacheArticlesID()
        self.logger.info("articles cache updated")
        return new_articles

    def checkUpdate(self):
        new_articles = []
        self.__getArticles()
        for art in self.__new:
            if art['_id'] not in self.__cachedArticlesID:
                self.__cachedArticlesID.append(art['_id'])
                new_articles.append(art)
        return new_articles

def build_embed(art):
    return Embed(title=art['title'], url=BLOG_URL+'/'+art['_id'],description=art['summary'], color=EMBED_COLOR)

def msg_new_article(art):
    return f"Nouveau post de {art['author']}!"