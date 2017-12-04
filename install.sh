#!/bin/sh

if [ $# -ne 1 ]; then
	echo "error: installation path not specified"
	exit 1
fi

basepath=$1

for file in $(find dotfiles/ -type f); do
	path="$basepath/$(echo $file | cut -d/ -f2-)"
	file="$PWD/$file"

	ans="y"
	if [ -e $path ]; then
		echo -n "overwrite $path? "
		read ans
		if [ "$ans" = "y" ]; then
			rm $path
		fi
	fi

	if [ "$ans" = "y" ]; then
		dir="$(dirname $path)"
		if [ ! -d $dir ]; then
			mkdir -p $dir
			echo "created directory $dir"
		fi
		ln -sf $file $path
		echo "installed $path"
	fi
done
