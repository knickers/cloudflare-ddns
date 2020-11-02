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
	if [ -n "${line%=*}" -a -n "${line#*=}" ]; then
		config["${line%=*}"]="${line#*=}"
	fi
done < "$1"

for k in api_token zone_id; do
	if [ -z "${config["$k"]}" ]; then
		echo "Missing config item: $k"
		exit 1
	fi
done

echo -n '('
for k in "${!config[@]}"; do
	echo -n "[$k]=${config[$k]} "
done
echo -n ')'
