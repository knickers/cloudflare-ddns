#!/bin/bash
set -e

declare -A CF
while read line
do
	CF["${line%=*}"]="${line#*=}"
done < cloudflare.conf

URL=${CF[subdomain]:+${CF[subdomain]}.}${CF[domain]}
OLD_IP=$(dig $URL +short @ns.cloudflare.com | awk '{ print; exit }')
NEW_IP=$(dig myip.opendns.com @resolver1.opendns.com +short)

if [[ ${CF[record]} != '' && $OLD_IP != $NEW_IP ]] ;
then
	curl https://www.cloudflare.com/api_json/ \
		-d 'a=rec_edit' \
		-d "email=${CF[email]}" \
		-d "tkn=${CF[token]}" \
		-d "z=${CF[domain]}" \
		-d "id=${CF[record]}" \
		-d "content=${NEW_IP}" \
		-d "display_content=${NEW_IP}"
fi
