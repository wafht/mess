#!/bin/sh
token="$1"
headers=" -H 'Accept-Encoding: gzip,deflate,sdch' -H 'Accept-Language: zh-CN,zh;q=0.8,en;q=0.6' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.117 Safari/537.36' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H 'Connection: keep-alive' --compressed"
tmp_url=$(wget -q -O- $header ip138.com | grep iframe | sed -r 's/.*iframe src="([^"]+)" .*/\1/g')
real_ip=$(wget -q -O- $header $tmp_url | iconv -f gb2312 | grep '您的IP是：' | sed -r 's/.*\[(.*)\].*/\1/g')
wget -O - "http://freedns.afraid.org/dynamic/update.php?$token&address=$real_ip" >> /tmp/freedns_wafht_chickenkiller_com.log 2>&1 &
