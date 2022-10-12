#!/bin/bash

if [[ $# -eq 0 ]]; then
  echo "usage list_regular_files.sh <directory to search>"
  exit 1
fi

words=""

read_words() {
  raw_words=$(<"$1")
  procesed_words=$(echo "$raw_words" | tr -c "A-Za-z" ' ')
  for word in $procesed_words; do
    # echo "$word"
    words="${words} ${word}"
  done
}

list_files() {
  for file in "$1"/*; do
    if [[ -d "$file" ]]; then
      list_files "$file"
    elif [ -f "$file" ]; then
      # echo "\"$file\""
      read_words "$file"
    fi
  done
}

do_counting() {
  echo "${words:1}" | tr [:space:] '\n'| sort | uniq -c
}

echo "Regular files in $1:"
list_files "$1"
do_counting