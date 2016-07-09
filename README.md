# [Alpine OS](https://hub.docker.com/_/alpine/) running [Tilestache](http://tilestache.org/)

Image size: 71.75 MB MB

This image is used to run Tilestache with help of nginx and uwsgi. It is expected that you have one folder in which you have mbtiles and test.cfg Tilestache configuration file.
It was only tested with mbtiles file. To use postgresql, mapnik etc. you would need to install additional packages. Paths to tilesets in test.cfg should be like all the files are in /app/ folder since this is path inside docker.

To start container use:
```
docker run --name iron-tilestache-uwsgi --restart=always --volume=/path/to/folder:/app -d -p 80:80  buma/alpine-tilestache
```

`-v /path/to/app/:/app` - specifies the path to the folder containing a file named test.cfg and mbtiles

`-p 80:80` - the image exposes port 80 (second number do not change), in this example it is mapped to port 80 (first number) on the host

Installed python packages:
```
ModestMaps (1.4.6)
Pillow (2.8.1)
pip (8.1.2)
setuptools (24.0.2)
simplejson (3.8.2)
TileStache (1.50.1)
Werkzeug (0.11.10)
```


---
## Internals
The tilestache is started using a UWSGI socket.

Nginx is used to map the socket to port 80 within the image. This image does not offer any SSL capability, please use a [nginx proxy](https://github.com/jwilder/nginx-proxy) for this. Nginx will deliver static content directly without going through uwsgi.

### Log messages
Logs can be displayed using `docker logs -f CONTAINER_ID/NAME`

---

To get the command line output of your app use `docker logs -f CONTAINER_ID/NAME`.
