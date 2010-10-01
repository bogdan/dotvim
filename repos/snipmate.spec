#!/bin/sh
git pull origin master
for dir in after autoload doc ftplugin plugin snippets syntax
do
	cp -rv $dir ~/.vim/
done

# removing provided snippets koz we have snipmate-snippets.spec
rm -rv ~/.vim/snippets/*.snippets
