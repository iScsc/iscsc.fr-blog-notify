from flask import Flask, request

from bot import start_bot

app = Flask("DiscordNotifyApp")

@app.route('/new-blog', methods=["POST"])
def new_blog():
    blog = request.get_json()
    return str(blog)


if __name__ == '__main__':
    app.run(host=('0.0.0.0'))
