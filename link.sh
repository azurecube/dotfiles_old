#! /bin/bash

DOT_ROOT=$(cd $(dirname $0);pwd)
for i in $(ls $DOT_ROOT/dot);do
  source=$DOT_ROOT/dot/$i
  dest=~/'.'$i
  if [ -e $dest ]; then continue; fi
  ln -s  $source $dest && echo link $dest is created
done
