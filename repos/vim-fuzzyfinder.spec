#!/bin/sh
hg pull
for repo in autoload doc plugin
do
	cp -rv $repo ~/.vim/
done
