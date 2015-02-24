#!/bin/bash
set -e

declare -A CF
while read line
do
	CF["${line%=*}"]="${line#*=}"
done < cloudflare.conf

set -x
URL=${CF[subdomain]:+${CF[subdomain]}.}${CF[domain]}
OLD_IP=$(dig $URL +short | awk '{ print; exit }')
NEW_IP=$(dig myip.opendns.com @resolver1.opendns.com +short)

# get the cloudflare record ID
#ALL_RECORDS=curl https://www.cloudflare.com/api_json/ \
curl https://www.cloudflare.com/api_json/ \
	-d "email=${CF[email]}" \
	-d "tkn=${CF[token]}" \
	-d "z=${CF[domain]}" \
	-d 'a=rec_load_all'
#	-d 'a=stats' \

# update the record with the new IP
: <<'END'
if [ ${OLD_IP} != ${NEW_IP} ] ;
then
	RESP=curl https://www.cloudflare.com/api_json/ \
		-d 'a=rec_edit' \
		-d "email=${CF[email]}" \
		-d "tkn=${CF[token]}" \
		-d "z=${CF[domain]}" \
		-d "id=${CF[id]}" \
		-d "content=${NEW_IP}" \
		-d "display_content=${NEW_IP}"
fi
END
