# Dependency-less CloudFlare Dynamic DNS

OK. One dependency, curl.

## Step by step instructions for ultra simple dynamic DNS through CloudFlare.

## Set up a CloudFlare account

CloudFlare does a fantastic job of guiding you through the signup and adding domains process. https://cloudflare.com

## Get a CloudFlare API token

## Find your record ID

This only has to be done once (per domain)

1. Add your credentials and domain name in the stats.sh file.
2. Open a terminal and run:

	./stats.sh

3. Paste the output (there might be a lot) into a json validator like [JSONLint](http://jsonlint.com).
4. Find the desired domain (or subdomain) record in the `response.recs.objs` array.
	* The `type` field will be "A" for regular website domains.
	* The `name` field will show the full domain name.
	* The `rec_id` field is the record ID we're after.

## Set up the bash script

1. Add your credentials, record ID, domain, and optional subdomain to the update.sh file.
2. Name update.sh something useful like `ddns-update-foo.example.com` (no file extension is needed, so `.com` is fine)
3. Put the file in a general location like `/usr/local/bin`

## Create a CRON job

1. In a terminal run:

	crontab -e

2. Add a line at the bottom like this:

	# minute hour day month weekday
	0 0 * * * ddns-update-foo.example.com

This will run the script every day at midnight (0 minute, 0 hour, all days).

## TODO

Write scripts to automatically find record IDs

* node
* php
* python
* ruby
