#!/bin/sh

PREFIX="toa.ping"
#COUNT="10"
#INTERVAL="3"
#REPEAT="1"
GRAPHITE="graphite.toa 2003"

PING_PARAMS="$PREFIX $COUNT $INTERVAL $REPEAT"

usage() {
cat <<EOF
Usage: $( basename $0 ) NETWORK

  NETWORK should be in form of 192.168.0 i.e. with last octet stripper

Example: $( basename $0) 10.0.0 

  All other configuration is done at the top of the file
EOF
exit 1
}

NETWORK=$1
[ -z "$NETWORK" ] && usage

PATH="$PATH:$(dirname $0)"

for octet in $(seq 1 254); do
  ping-graphite.sh "$NETWORK.$octet" $PING_PARAMS | nc $GRAPHITE &
done
