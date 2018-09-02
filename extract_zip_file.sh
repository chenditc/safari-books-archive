#!/bin/bash
set -e
set -x

zip_file=$1
if [ -f "$zip_file" ]
then
    mkdir -p /tmp/safari-book/
    unzip -o -d /tmp/safari-book/ $zip_file 
    for mhtml_file in $(ls /tmp/safari-book/*/*.mhtml)
    do
        ./mhtml_to_html_converter.py $mhtml_file ./site 
    done
    rm -rf /tmp/safari-book/
else
    echo "$zip_file does not exists"
    exit 1
fi

