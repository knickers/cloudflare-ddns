#!/bin/bash
set -e

declare -A config=$( ./read-config.sh "$@" )

for k in domain record_id; do
	if [ -z "${config["$k"]}" ]; then
		echo "Missing config item: $k"
		exit 1
	fi
done

OLD_IP=$(dig ${config[domain]} +short @ns.cloudflare.com | awk '{ print; exit }')
NEW_IP=$(dig myip.opendns.com @resolver1.opendns.com +short)

if [ $OLD_IP = $NEW_IP ]; then
	echo 'Same IP address'
	exit
fi

API="https://api.cloudflare.com/client/v4/zones/${config[zone_id]}"

curl -X PATCH "$API/dns_records/${config[record_id]}" \
	-H "Authorization: Bearer ${config[api_token]}" \
	-H 'Content-Type:application/json' \
	--data '{"content":"'"$NEW_IP"'"}'

echo
