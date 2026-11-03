#!/bin/bash

LOCK_FILE="report.lock"
REPORT_FILE="report.txt"
cleanup_interrupt()
{
    echo "Прервано" >&2
    rm -f "$LOCK_FILE" "$REPORT_FILE"
    exit 1
}
trap cleanup_interrupt SIGINT SIGTERM

if [ "$1" == "--help" ]; then
    echo "  -p, --players <file>      players log"
    echo "  -b, --banlist <file>      banlist file"
    echo "  -t, --transactions <file> transactions log"
    exit 0
fi

if ! (set -o noclobber; echo "$$" > "$LOCK_FILE") 2>/dev/null; then
    echo "Report in progress" >&2
    exit 1
fi

PLAYERS_F=""
BANLIST_F=""
TRANS_F=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        -p|--players)
            PLAYERS_F="$2"; shift 2 ;;
        -b|--banlist)
            BANLIST_F="$2"; shift 2 ;;
        -t|--transactions)
            TRANS_F="$2"; shift 2 ;;
        *)
            shift ;;
    esac
done

if [ ! -f "$PLAYERS_F" ] || [ ! -f "$BANLIST_F" ] || [ ! -f "$TRANS_F" ]; then
    echo "Error: Missing or invalid log files." >&2
    rm -f "$LOCK_FILE"
    exit 1
fi

p_count=$(wc -l < "$PLAYERS_F")
b_count=$(wc -l < "$BANLIST_F")
t_count=$(wc -l < "$TRANS_F")

top_item=$(awk '{print $NF}' "$TRANS_F" | sort | uniq -c | sort -nr | head -n1 | awk '{print $2}')

cat << EOF > "$REPORT_FILE"
StarCraft server report

Players: $p_count
Bans: $b_count
Transactions: $t_count
Top item: $top_item
EOF

rm -f "$LOCK_FILE"
exit 0

