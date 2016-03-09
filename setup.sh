#!/bin/bash
FILE=$0
DIR=$(dirname "$FILE")/
THIS=${FILE#$DIR}

FILES=$(ls -AI "$THIS")
for f in $FILES; do
  ln -s $HOME/$f $f
done
