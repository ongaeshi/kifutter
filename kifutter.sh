#!/bin/bash
#

APP_DIR=/home/ongaeshi/web/kifutter
APP_NAME=kifutter
PORT=10000
ENV=deployment
LIBDIR="$APP_DIR"
SERVER=webrick
RACKUP=/usr/local/bin/rackup

RETVAL=0

# Gracefully exit if the rackup is missing.
# which rackup >/dev/null || exit 0

# Go no further if config directory is missing.
[ -d "$APP_DIR" ] || exit 0

function start
{
    # setup env
    export DATABASE_URL="sqlite://$APP_DIR/db/kifutter.db"
    export LOG_DIR="$APP_DIR/log"
    export SETUP_FILE="$APP_DIR/setup"

    # rackup
    ARGS="$LIBDIR/config.ru -s $SERVER -p $PORT -E $ENV -D -I $LIBDIR"
    echo $RACKUP $ARGS
    $RACKUP $ARGS
    RETVAL=$?

    # watcher
    ARGS="-I $LIBDIR -rdaemonize $APP_DIR/watcher.rb"
    echo ruby $ARGS
    ruby $ARGS

    sleep 3
    if pgrep -f 'kifutter'
    then
      echo "$APP_NAME listened at $PORT"
    else
      echo "error: $APP_NAME bootup was failed."
    fi
}

function stop
{
    pkill -f 'kifutter/config.ru' 
    pkill -f 'kifutter.*watcher.rb'

    sleep 3
    pgrep -f 'kifutter'
    echo "$APP_NAME was terminated"
}

case "$1" in
    start)
	start
	;;
    stop)
	stop
	;;
    restart)
	stop
	start
	;;
    *)
	echo "Usage: $APP_NAME {start|stop|restart}"
	exit 1
	;;
esac

exit $RETVAL
