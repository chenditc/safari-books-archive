#!/bin/bash
set -e
set -x

if [ -z "$1" ]
then
    echo "No argument supplied"
    exit 1
fi

#target_url="http://dev.chendi.me/library/view/data-mining-practical/9780123748560/xhtml/big.html"
target_url=$1

file_name=$(basename $target_url | cut -f 1 -d '.').mobi

job_result=$(curl 'https://www.online-convert.com/formconvert' -H 'pragma: no-cache' -H 'origin: https://ebook.online-convert.com' -H 'accept-encoding: gzip, deflate, br' -H 'accept-language: en-US,en;q=0.9,zh-CN;q=0.8,zh;q=0.7,zh-TW;q=0.6' -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36' -H 'content-type: application/x-www-form-urlencoded; charset=UTF-8' -H 'accept: */*' -H 'cache-control: no-cache' -H 'authority: www.online-convert.com' -H 'referer: https://ebook.online-convert.com/convert-to-mobi' --data 'target=mobi&category=ebook&reader=default&title=&author=&border=&base_font_size=&encoding=&save_settings_name=&string_method=convert-to-mobi&upload_token='  --data-urlencode "external_url=$target_url" --compressed)
job_id=$(echo $job_result | python -c "import sys, json; print json.load(sys.stdin)['job_id']")

timeout=300
until wget https://www.online-convert.com/downloadFile/$job_id/$file_name 
do
    timeout=$((timeout-1))
    if [[ "$counter" -lt 0 ]]
    then
        exit 1
    fi
    sleep 1
done

