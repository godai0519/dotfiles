#!/bin/sh

source `dirname $0`/lock.sh

dir=$HOME/Dropbox/Wallpaper
managed_image=$HOME/.wallpaper/tmp.png
interval_time=180

while :; do
    image_num=`ls -1 $dir | wc -l`
    timestamp=`date +%s`
    random_number=`expr $timestamp % $image_num + 1`
    image_name=`ls -1 $dir | head -n $random_number | tail -n 1`

    cp -f "$dir/$image_name" "$managed_image"
    nitrogen --restore

    sleep $interval_time;
done

