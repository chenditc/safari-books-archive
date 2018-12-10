rm index.html
find ./site -name '*.html' | sort | while read path
do
    echo $path | sed 's/\.\///g' | python3 -c "relative_path=input(); name=relative_path.replace('site/library/view/', ''); print('<h3><a href={0}>{1}</a></h3>'.format(relative_path, name))" >> index.html
done
