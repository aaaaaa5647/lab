#!/bin/bash

format()
{
    local file="$1"
    [ ! -f "$file" ] && return 1
    sed '/^11_Steve_11 /d' "$file" | sort -u > "${file}.tmp" && mv "${file}.tmp" "$file"
}
add() 
{
    local input="$*"
    local nick=$(echo "$input" | awk '{print $1}')
    local time=$(echo "$input" | awk '{print $2}')
    local reason=$(echo "$input" | awk '{for (i = 3; i <= NF; i++) printf "%s ", $i; print ""}' | sed 's/ $//')
    local entry="${nick} ${time} ${reason}"
    local file="banlist.txt"    
    [ ! -f "$file" ] && touch "$file"   
    if ! grep -q "^${nick} " "$file"; then
        echo "$entry" >> "$file"
    fi
}
info() 
{
    local nick="$1"
    local file="banlist.txt"
    [ ! -f "$file" ] && return 1
    grep "^${nick} " "$file"
}
remove()
{
    local nick="$1"
    local file="banlist.txt"
    [ ! -f "$file" ] && return 1
    sed -i "/^${nick} /d" "$file"
}
sort2() 
{
    local type="$1"
    local file="$2"
    [ ! -f "$file" ] && return 1   
    if [ "$type" == "--name" ]; then
        sort -k1,1 "$file"
    elif [ "$type" == "--time" ]; then
        sort -t ':' -k3,3n -k2,2n -k1,1n "$file"
    fi
}

case "$1" in
    format)
        format "$2" ;;
    add)
        shift
        add "$@" ;;
    info)
        info "$2" ;;
    remove)
        remove "$2" ;;
    sort)
        sort2 "$2" "$3" ;;
    *)
        echo "Ошибка" >&2
        exit 1  ;;
esac

