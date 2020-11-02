#!/bin/bash
set -e

declare -A config=$( ./read-config.sh "$@" )

API="https://api.cloudflare.com/client/v4/zones/${config[zone_id]}"

if [ -n "${config[domain]}" ]; then
	domain="&name=${config[domain]}"
fi

curl -v "$API/dns_records?type=A$domain" \
	-H "Authorization: Bearer ${config[api_token]}" \
	-H 'Content-Type:application/json' \

echo
