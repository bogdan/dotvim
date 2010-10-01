#!/bin/sh
git pull origin master
for dir in ftdetect syntax
do
	cp -rv $dir ~/.vim/
done
