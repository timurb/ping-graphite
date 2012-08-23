#!/bin/sh

usage() {
cat << EOF
Usage: $(basename $0) TARGET PREFIX [COUNT] [INTERVAL] [REPEAT]
EOF
exit 1
}

ping_box() {
  VALUE="$(ping -c "$COUNT" -i "$INTERVAL" -q "$TARGET" | grep 'rtt min/avg/max/mdev' | cut -d/ -f5)"

  [ -z "$VALUE" ] && continue

  DISPTARGET=$(echo $TARGET | sed 's,\.,_,g')

  echo "$PREFIX.$DISPTARGET $VALUE $(date +%s)"
}

TARGET=$1
PREFIX=$2
COUNT=$3
INTERVAL=$4
REPEAT=$5

[ -z "$PREFIX" ] && usage

[ -z "$COUNT" ] && COUNT=1
[ -z "$INTERVAL" ] && INTERVAL=1

ping_box
while [ -n "$REPEAT" ]; do
  ping_box
done 
