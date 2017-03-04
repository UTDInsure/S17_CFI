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

cd splittemp

for filename in ../$1/*.txt
do
  csplit -n5 -s --prefix=${filename##*/} $filename "/========/+1" "{*}"
done

cd ..

for filename in splittemp/*
do
  # analyze the gadget
  awk -f cleanup.awk $filename
done

rm -rf splittemp
