#!/bin/sh
git pull origin master
for dir in ftdetect ftplugin indent syntax
do
	cp -rv $dir ~/.vim/
done
