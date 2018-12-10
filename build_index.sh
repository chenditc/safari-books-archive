#!/bin/bash
rm index.html
find ./site -name '*.html' | sort | while read path
do
    echo $path | sed 's/\.\///g' | python3 -c "relative_path=input(); name=relative_path.replace('site/library/view/', ''); book_name = name.split('/')[0]; chap_name=name.split('/')[-1];  print('<h3>{2}: <a href={0}>{1}</a></h3>'.format(relative_path, chap_name, book_name))" >> index.html
done
