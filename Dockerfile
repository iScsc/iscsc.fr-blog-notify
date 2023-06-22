FROM python:3.10.9

COPY requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt

WORKDIR /opt/iscsc.fr-notify-bot
COPY . .

# root group already exists, but we need to create the blog_root user
# Documentation for RUN useradd : https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#user
# Documentation for USER : https://docs.docker.com/engine/reference/builder/#user
RUN useradd --no-log-init --system --gid root blog_bot
USER blog_bot:root

ENTRYPOINT ["python3"]
CMD ["/opt/iscsc.fr-notify-bot/main.py"]
