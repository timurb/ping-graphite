#!/bin/sh

usage() {
cat << EOF
Usage: $(basename $0) TARGET PREFIX [COUNT] [REPEAT]
EOF
exit 1
}

ping_box() {
  VALUE="$(ping -c "$COUNT" -q "$TARGET" | grep 'rtt min/avg/max/mdev' | cut -d/ -f5)"

  [ -z "$VALUE" ] && continue

  DISPTARGET=$(echo $TARGET | sed 's,\.,_,g')

  echo "$PREFIX.$DISPTARGET $VALUE $(date +%s)"
}

TARGET=$1
PREFIX=$2
COUNT=$3
REPEAT=$4

[ -z "$PREFIX" ] && usage

[ -z "$COUNT" ] && COUNT=1

ping_box
while [ -n "$REPEAT" ]; do
  ping_box
done 
