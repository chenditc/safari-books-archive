#!/bin/bash
set -e
set -x

for zip_file in $(ls zip_files)
do
    ./extract_zip_file.sh zip_files/$zip_file
done

./build_index.sh 
