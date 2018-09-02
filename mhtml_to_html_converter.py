#!/usr/bin/env python3
import logging
import re
import base64
import email, email.message
import mimetypes
import os
import quopri
import sys 
import argparse
import glob

def save_part(part):
    content_path = part.get("content-location")
    if content_path is None:
        logging.error("Can't find content path ini {}".format(file_name))
        return

    # Remove domain name
    path = re.sub(r'http(s*)://[a-zA-z0-9.]*[\/]+', '', content_path)
    if os.path.dirname(path):
        os.makedirs(os.path.dirname(path), exist_ok=True)

    # Remove safaribooks link
    content = part.get_payload(decode=True)
    try:
        temp_content = content.decode("utf-8")
        content = re.sub(r'href="https\:\/\/www.safaribooksonline.com\/library\/view', 'href="/Library/view', temp_content).encode("utf-8")
    except:
        pass 
    open(path, "wb").write(content)

def convert_mhtml_to_html(file_name, dest):
    os.makedirs(dest, exist_ok=True)
    os.chdir(dest)

    # Read all mhtml file and decode
    with open(file_name, "rb") as input_file:
        mhtml_file = email.message_from_bytes(input_file.read())
        parts = mhtml_file.get_payload()

        for part in parts:
            save_part(part)
        print("Converted file: {}".format(file_name))

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Extract mhtml into html file and remove certain url")
    parser.add_argument("mhtml", metavar="mhtml", help='path to mhtml file')
    parser.add_argument("dest", metavar="dest", help="destination directory to store") 
    args = parser.parse_args()

    file_name = args.mhtml
    dest = args.dest

    convert_mhtml_to_html(file_name, dest)

