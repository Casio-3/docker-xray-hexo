#!/bin/sh

cd /var/www && git pull

curtime=`date +"%Y%m%d%H%M%S"`

if [ $? -eq 0 ];then
    echo "$curtime pull success!" >> /webhook/git.log
else
    echo "$curtime pull fail!" >> /webhook/git.log
fi