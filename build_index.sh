find ./site -name '*.html' | sort | sed 's/\.\//<h2> /g' | sed 's/$/ <\/h2> /g' > index.html
