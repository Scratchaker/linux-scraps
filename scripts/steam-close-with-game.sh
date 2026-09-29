#!/usr/bin/env bash

APPID="400"
SHUTDOWN_DELAY=2

if pgrep -x steam > /dev/null; then
    echo "Steam is already running. Launching game without auto-shutdown behavior."
    steam -silent "steam://rungameid/${APPID}"
    exit 0
fi

rm -f "/tmp/steam-output-to-analyze.log"
script -qc "steam -silent steam://rungameid/${APPID}" "/tmp/steam-output-to-analyze.log" | while IFS= read -r line; do
    echo "$line"
    if [[ "$line" == *"Game Recording - game stopped [gameid=${APPID}]"* ]]; then
        echo "Detected game stop for appid ${APPID}. Waiting ${SHUTDOWN_DELAY}s before shutting down Steam..."
        sleep "$SHUTDOWN_DELAY"
        steam -shutdown
        break
    fi
done
