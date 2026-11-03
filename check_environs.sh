#!/bin/bash

CONF_FILE="server.conf"
if [ -z "$SERVER_NAME" ]; then
    VAL_SERVER_NAME="StarCraft"
else
    VAL_SERVER_NAME="$SERVER_NAME"
fi
if [ -z "$MAX_PLAYERS" ]; then
    VAL_MAX_PLAYERS=125
else
    VAL_MAX_PLAYERS="$MAX_PLAYERS"
fi
if [ -z "$SPAWN_COORDS" ]; then
    VAL_SPAWN_COORDS="274 67 -249"
else
    VAL_SPAWN_COORDS="$SPAWN_COORDS"
fi

echo "SERVER_NAME=\"$VAL_SERVER_NAME\"" > "$CONF_FILE"
echo "MAX_PLAYERS=$VAL_MAX_PLAYERS" >> "$CONF_FILE"
echo "SPAWN_COORDS=\"$VAL_SPAWN_COORDS\"" >> "$CONF_FILE"
cat "$CONF_FILE"
