#!/bin/bash

if [[ $# -eq 0 ]]; then
  echo "usage list_regular_files.sh <directory to search>"
  exit 1
fi

change_letter() {
  contents=$(<"$1")
  modyfied=$(echo "$contents" | tr 'a' 'A' )
  echo -n "$modyfied" > "$1"
}

list_files() {
  for file in "$1"/*; do
    if [[ -d "$file" ]]; then
      list_files "$file"
    elif [ -f "$file" ]; then
      change_letter "$file"
    fi
  done
}

list_files "$1"