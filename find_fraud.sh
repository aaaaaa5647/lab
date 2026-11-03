#!/bin/bash
if [ -z "$1" ] || [ ! -f "$1" ]; then
    echo "Ошибка" >&2 
    exit 1
fi
awk '{ b[$1]-=$4; b[$3]+=$4 } END { for(p in b) if(b[p]<0) print p }' "$1"
