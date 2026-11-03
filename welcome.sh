#!/bin/bash
name=$1

if [[ "$name" =~ ^[A-Za-z0-9_]{3,16}$ ]]; then
    echo "Welcome, $name!"
else
    echo "Invalid nickname" >&2
    exit 1
fi
