FROM iron/python:2

MAINTAINER Marko Burjek <s0mebody.slo@gmail.com>

#UWSGI & Nginx based on jazzdd86/alpine-flask

RUN apk add --update \
	py-pillow \
	py-pip \
	nginx uwsgi uwsgi-python &&   rm -rf /var/cache/apk/* && pip install -U pip setuptools && pip install TileStache==1.50.1


# application folder
ENV APP_DIR /app

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

RUN mkdir /data \
	&& chown -R nginx:nginx /data
VOLUME [/data/terrain]
VOLUME [/data/tilesets]

#RUN chown -R nginx:nginx /var/log/nginx

ENTRYPOINT ["/start.sh"]

