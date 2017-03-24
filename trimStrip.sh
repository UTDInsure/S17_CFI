#!/bin/bash
cFile="inlineAssembly.c"
logFile="1gadget.log"
if [ $# -gt 0 ]; then
  if [ $# -gt 1 ]; then
    echo "ERROR: Too many arguments"
    exit 1
  else
    echo "Working on :" $1
  fi
else
  echo "ERROR: Did not include a folder to work with"
  exit 1
fi

[ -d goodGadgets ] || mkdir goodGadgets

for filename in $1/*
do
  var1="asm(\".intel_syntax noprefix\\\\n\\\\t\""
  var2="\".att_syntax prefix\");"

  insert=$(cat $filename | tail -n+2 | head -n -2 | sed '$d' | sed '$d' | tr -s [:blank:] | cut -d' ' -f2- | rev | cut -d' ' -f3- | rev | tr A-Z a-z | sed 's/^/"/;s/$/\\n\\t"/' | sed "1s/.*/$var1/" | awk '1; END {print "\".att_syntax prefix\");"}')
  match="//Insert"
  echo $insert > temp.txt
  sed "/Insert/r temp.txt" $cFile > com.c
  gcc -o run com.c
  if [ $? -gt 0 ]; then
    echo $filename " failed to compile" >> $logFile
  else
    ./run
    if [ $? -gt 0 ]; then
      echo $filename " didn't change eax by one" >> $logFile
    else
      echo $filename " changed eax by one" >> $logFile
      cp $filename goodGadgets
    fi
  fi
done
#rm com.c run

