FROM python:3.10.9
RUN pip install --upgrade pip

COPY requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt

RUN apt update && apt install -y vim

# root group already exists, but we need to create the blog_root user
# Documentation for RUN useradd : https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#user
# Documentation for USER : https://docs.docker.com/engine/reference/builder/#user
RUN useradd --no-log-init --system --gid root blog_bot

EXPOSE 5000
USER blog_bot

WORKDIR /opt/blog_bot

ENTRYPOINT ["bash"]
