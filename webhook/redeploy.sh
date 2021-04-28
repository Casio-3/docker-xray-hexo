#!/bin/sh

cd /var/www/hexo && git pull

curtime=`date +"%Y%m%d%H%M%S"`

if [ $? -eq 0 ];then
    echo "$curtime pull success!" >> /var/webhook/git.log
else
    echo "$curtime pull fail!" >> /var/webhook/git.log
fi