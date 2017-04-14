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

for filename in $1/*
do
	count=$(cat $filename | grep "AX" | wc -l)
	if [ $count -lt 2 ]; then
		success=$(cat $filename | egrep "83E801|83C001|\[FFD0\]" | wc -l)
		if [ $success -gt 0 ]; then
			f=$(basename "$filename")
			cp $filename /Users/Jeremiah/College/insure/eaxControl/$f
			#echo "Success: " $filename
		#else
			#echo "Failure: "
		fi
	#else 
		#echo "Failure: " $count
	fi
done