#!/bin/sh
git pull origin master
for dir in doc plugin
do
	cp -rv $dir ~/.vim/
done
