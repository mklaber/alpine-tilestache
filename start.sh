#!/bin/sh

nginx && exec uwsgi --ini /app.ini --eval "import TileStache; application = TileStache.WSGITileServer('test.cfg')"
