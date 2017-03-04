#!/bin/bash

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
[ -d hard ] || mkdir hard
[ -d easy ] || mkdir easy
cd splittemp

for filename in ../$1/*.txt
do
  csplit -n5 -s --prefix=${filename##*/} $filename "/========/+1" "{*}" #change to gcsplit on MacOS
done


for file in splittemp/*
do
	hard=false
	IFS=$'\n' read -d '' -r -a lines < $file  #make an array called lines from the file 
	if [ ${#lines[@]} -lt 4 ]; then #make sure our gadget is big enough to test
		continue
	fi
	for i in $(seq 1 $((${#lines[@]} - 3 )));  #skips the first and last command of every gadget
	do
		tokens=( ${lines[$i]} )  #tokenize the line
		case "${tokens[1]}" in  #test the command part of the line
  			J*|CALL)
    			hard=true
    			;;
		esac
	done

	if $hard; then
		cp $file hard
	else
		cp $file easy
	fi

done


# rm -rf splittemp
