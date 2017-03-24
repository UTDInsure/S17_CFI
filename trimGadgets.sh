#!/bin/bash
cFile="inlineAssembly.c"
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

var1="asm(\".intel_syntax noprefix\\n\\t\""
var2="\".att_syntax prefix\");"

insert=$(cat f | tail -n+2 | sed '$d' | sed '$d' | tr -s [:blank:] | cut -d' ' -f2- | rev | cut -d' ' -f3- | rev | tr A-Z a-z | sed 's/^/"/;s/$/\\n\\t"/' | sed "1s/.*/$var1/" | awk '1; END {print "\".att_syntax prefix\");"}')
match="//newcode"
echo $insert > temp.txt
sed -i "s/$match\n$insert/" $cFile