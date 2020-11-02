# Dependency-less CloudFlare Dynamic DNS

Okay, one dependency. `Curl`

This script is compatible with CloudFlare's v4 API.


### Create config file

```
api_token=[your cloudflare api token]
zone_id=[your cloudflare zone id]
domain=[domain name of the record to be updated. e.g. example.com]
record_id=[id of the domain record to be updated]
```

It's recommended that the api token only has permissions to edit the DNS for
the specific domain in question, and no other permissions.

Don't use quotes around the keys or values in the config file.


### Find the record ID

1. Open a terminal and run:

	`./list.sh [path/to/config/file]`

2. The JSON output is difficult to read, paste it into a json validator like
	[JSONLint](http://jsonlint.com).
3. Find the desired domain record in the `result` array.
	* The `id` field is the needed record id.
	* The `name` field will show the full domain name.
4. Add the id to the config file under `record_id`


### Run the script

`/path/to/cloudflare-ddns/update.sh    /path/to/config/file`


### Create a CRON job

1. In a terminal run:

	`crontab -e`

2. Add a line at the bottom like this:

	`0 0 * * *    /path/to/cloudflare-ddns/update.sh    /path/to/config/file`

This will run the script every day at midnight (0 minute, 0 hour, all days).
