#!/bin/sh
git pull origin master
for dir in doc plugin syntax
do
	cp -rv $dir ~/.vim/
done
