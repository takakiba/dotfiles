#!/usr/bin/bash

set -u

BASEDIR=$(dirname $0)
cd $BASEDIR

for f in .??*; do
    [ "$f" = '.git' ] && continue

    ln -snfv ${PWD}/"$f" $HOME/
done

