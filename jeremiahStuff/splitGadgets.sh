#!/usr/local/Cellar/bash/4.4.12/bin/bash

if [ $# -gt 0 ]; then
  if [ $# -gt 1 ]; then
    echo "ERROR: Too many arguments"
    exit 1
  else
    echo "Working on :" $1
  fi
else
  echo "ERROR: Did not include a folder to sort"
  exit 1
fi

[ -d splittemp ] || mkdir splittemp
dest="/Users/Jeremiah/College/splitTest/splittemp"
cd $1
shopt -s globstar

for filename in **/*.txt;
do
	currentDir=$(pwd)
	f=$(basename "$filename")
	cd $dest
 	gcsplit -n5 -s --prefix="$dest/$f" "$currentDir/$filename" "/========/+1" "{*}"  #change to gcsplit on MacOS
 	cd $1
done

cd ..