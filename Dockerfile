FROM python:3

# MAINTAINER Marko Burjek <s0mebody.slo@gmail.com>


RUN set -ex; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
	python-pil \
	nginx uwsgi && \
	pip install -U pip setuptools && pip install uwsgi && pip install numpy Pillow && pip install TileStache==1.51.13


# application folder
ENV APP_DIR /app

RUN groupadd --gid 1000 nginx \
	&& useradd --uid 1000 --gid nginx --shell /bin/bash --create-home nginx

# app dir
RUN mkdir ${APP_DIR} \
	&& chown -R nginx:nginx ${APP_DIR} \
	&& chmod 777 /run/ -R \
	&& chmod 777 /root/ -R
VOLUME [${APP_DIR}]
WORKDIR ${APP_DIR}

# expose web server port
# only http, for ssl use reverse proxy
EXPOSE 80

# copy config files into filesystem
COPY nginx.conf /etc/nginx/nginx.conf
COPY app.ini /app.ini
COPY start.sh /start.sh

ENTRYPOINT ["/start.sh"]

