#!/bin/bash

if [ -z "$1" ] || [ ! -f "$1" ]; then
    echo "Ошибка" >&2 
    exit 1
fi

awk '
{
    from = $1
    to = $3
    amount = $4
    
    balance[from] -= amount
    balance[to] += amount
}
END
{
    for (player in balance)
    {
        if (balance[player] < 0)
	{
            print player
        }
    }
}
' "$1"

