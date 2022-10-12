#!/bin/bash

if [[ $# -eq 0 ]]; then
  echo "usage list_regular_files.sh <directory to search>"
  exit 1
fi

read_words() {
  while read line; do
    processed_line=$(echo "$line" | tr -c "a-zA-Z" ' ' | tr -s ' ' '\n' | sort | uniq -c)
    while read word; do
      number=$(echo $word | cut -d " " -f1)
      if (( number > 1 )); then 
        echo -e "$(echo $word | cut -d " " -f2) @ $1: $line"
      fi
    done <<< "$processed_line"
  done < "$1"
}

list_files() {
  for file in "$1"/*; do
    if [[ -d "$file" ]]; then
      list_files "$file"
    elif [ -f "$file" ]; then
      read_words "$file"
    fi
  done
}

echo "Regular files in $1:"
list_files "$1"