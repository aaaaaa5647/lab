#!/bin/bash
if [ -z "$1" ] || ! [ -f "$1" ]; then
    echo "Ошибка" >&2
    cat "$1" 2>&1 >/dev/null
    exit 1
fi

awk -v word="${2:-Hello}" ' BEGIN { print word } { b[$1]-=$4; b[$3]+=$4 } END { for(p in b) if(b[p]<0) print p }' "$1"
