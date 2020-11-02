#!/bin/bash
set -e

if [ -z "$1" ]; then
	echo 'Please specify a config file.'
	exit 1
fi

if [ ! -e "$1" ]; then
	echo "Cannot find config file: $1"
	exit 1
fi

declare -A config

while read line; do
	config["${line%=*}"]="${line#*=}"
done < "$1"

for k in "${!config[@]}"; do
	echo "[$k]=${config[$k]}"
done
