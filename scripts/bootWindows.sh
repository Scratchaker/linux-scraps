#!/usr/bin/env bash

if [ "$EUID" -ne 0 ]; then
  exec pkexec "$(readlink -f "$0")" "$@"
fi

OS="Windows Boot Manager"
OS_ID=$(efibootmgr | awk -v os="$OS" '$0 ~ os { match($0, /Boot([0-9]+)\*?/, m); printf "%s", m[1] }')

efibootmgr -n "$OS_ID"
reboot
