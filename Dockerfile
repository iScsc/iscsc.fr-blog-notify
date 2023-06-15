FROM python:3.10.9

COPY requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt

WORKDIR /opt/iscsc.fr-notify-bot
COPY . .

ENTRYPOINT ["python3"]
CMD ["/opt/iscsc.fr-notify-bot/main.py"]
USER blog_bot[:root]
