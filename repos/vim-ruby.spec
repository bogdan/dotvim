#!/bin/sh
git pull origin master
for dir in autoload compiler ftdetect indent syntax
do
	cp -rv $dir ~/.vim/
done
# too many questions...
# ruby bin/vim-ruby-install.rb
