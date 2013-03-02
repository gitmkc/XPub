#!/bin/sh

filename=$1

echo "copying...."

scp $1 root@115.254.33.60:/var/www/publish/webapp/scripts/test-scripts


echo "Finish!"
