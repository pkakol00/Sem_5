#!/bin/bash

if [[ $# -eq 0 ]]; then
  echo "usage list_regular_files.sh <directory to search>"
  exit 1
fi

list_files() {
  for file in "$1"/*; do
    if [[ -d "$file" ]]; then
      list_files "$file"
    elif [ -f "$file" ]; then
      echo "\"$file\""
    fi
  done
}
echo "Regular files in $1:"
list_files "$1"