from dotenv import load_dotenv
load_dotenv()

from flask import Flask, request, abort

from webhook import notify

app = Flask("DiscordNotifyApp")

@app.route('/new-blog', methods=["POST"])
def new_blog():
    article = request.get_json()
    keys = ["title", "author", "summary", "url"]
    for key in keys:
        if key not in article:
            app.logger.error("Missing JSON info for new blog post: '%s'", key)
            abort(400)

    notify(article)
    app.logger.info("Request correct: notification sent")

    return "Request correct: new article notification sent.\n"

if __name__ == '__main__':
    app.run(host=('0.0.0.0'))
