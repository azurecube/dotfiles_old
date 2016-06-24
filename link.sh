#! /bin/bash

DOT_ROOT=$(cd $(dirname $0);pwd)
for i in $(ls $DOT_ROOT/dot);do
  ln -s $DOT_ROOT/dot/$i ~/'.'$i
done
