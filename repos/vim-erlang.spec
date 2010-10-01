#!/bin/sh
git pull origin master
for dir in autoload compiler ftplugin indent syntax
do
	cp -rv $dir ~/.vim/
done
