from flask import Flask

from bot import start_bot

app = Flask("DiscordNotifyApp")

@app.route('/new-blog', methods=["POST"])
def hello_world():
    blog = request.get_json()
    return str(blog) or "nothing"


if __name__ == '__main__':
    app.run(host=('0.0.0.0'))
