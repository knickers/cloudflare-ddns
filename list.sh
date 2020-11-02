#!/bin/bash
set -e

declare -A config=$( ./read-config.sh "$@" )

API="https://api.cloudflare.com/client/v4/zones/${config[zone_id]}"

curl "$API/dns_records?type=A" \
	-H "Authorization: Bearer ${config[api_token]}" \
	-H 'Content-Type:application/json' \

echo
