#!/bin/bash
rm *.html
rm ./site/*.html

# Create per book index
find ./site -name '*.html' | sort | while read path
do
    bookname=$(echo $path | sed 's/\.\///g' | cut -d "/" -f 4) 
    echo $path | sed 's/\.\/site\///g' | python3 -c "relative_path=input(); name=relative_path.replace('library/view/', ''); book_name = name.split('/')[0]; chap_name=name.split('/')[-1];  print('<h3>{2}: <a href={0}>{1}</a></h3>'.format(relative_path, chap_name, book_name))" >> ./site/${bookname}.html
done

# Create total index
ls ./site/*.html | sort | while read path
do
    echo $path | sed 's/\.\/site\///g' | python3 -c "relative_path=input(); print('<h3><a href=site/{0}>{0}</a></h3>'.format(relative_path))" >> ./index.html
done

