#!/bin/sh
set -e

path=$1

git submodule deinit -f -- $path
rm -rf .git/modules/$path
git rm -f $path

