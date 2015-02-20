#!/bin/bash
set -e
set -x

#IP=curl ifconfig.me/ip

declare -A CF
while read line
do
	CF["${line%=*}"]="${line#*=}"
done < cloudflare.conf

# get the cloudflare record ID
#ALL_RECORDS=curl https://www.cloudflare.com/api_json/ \
curl https://www.cloudflare.com/api_json/ \
	-d "tkn=${CF[token]}" \
	-d "email=${CF[email]}" \
	-d "z=${CF[website]}" \
	-d 'a=stats'
#	-d 'a=rec_load_all'

# update the record with the new IP
#RESP=curl https://www.cloudflare.com/api_json/ \
#	-d "tkn=${CF_TOKEN}" \
#	-d "email=${CF_EMAIL}" \
#	-d "z=${CF_SITE}" \
#	-d 'a=rec_edit' \
#	-d "id=${ID}" \
#	-d "content=${IP}" \
#	-d "display_content=${IP}"
