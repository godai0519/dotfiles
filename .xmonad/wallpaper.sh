#!/bin/sh
DIR=$HOME/Dropbox/Wallpaper
MNG_FILE=$HOME/.wallpaper/tmp.png
SLEEP=180

while :; do
    NUM_JPG=`ls $DIR | wc -l`
    TIMESTAMP=`date +%s`
    RAND=`expr $TIMESTAMP % $NUM_JPG + 1`
    TMP=`ls $DIR | head -$RAND | tail -1`

    cp -f $DIR/$TMP $MNG_FILE
    nitrogen --restore

    sleep $SLEEP;
done

