#!/bin/sh

# assumes no paths contain spaces!

cd $(dirname $0)/dotfiles

for src in $(find -type f -printf '%P\n'); do
	dst=$HOME/$src
	dir=$(dirname $dst)

	if [ ! -d $dir ]; then
		mkdir -p $dir
		echo "created directory $dir"
	elif [ -e $dst ] && ! cmp -s $src $dst; then
		echo -n "overwrite $dst? "
		read ans && [ "$ans" != "y" ] && continue
	fi

	ln -sf $PWD/$src $dst
	echo "installed $dst"
done
