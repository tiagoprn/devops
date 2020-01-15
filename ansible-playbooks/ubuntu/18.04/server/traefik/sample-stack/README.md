## Map your local IPs to match domains that will be used on traefik

Run the script to configure your local dns:

`$ sudo ./local_dns.sh`.


## The traefik dashboard

The credentials to enter traefik dashboard are:

`admin / 12345678`

This user/password combination is configured on `traefik.toml`, at `entryPoints.dashboard.auth.basic`. To generate the string containing the password, you must use `htpasswd`, e.g.:

`$ htpasswd -n -B admin`

, or an [online htpasswd generator](http://www.htaccesstools.com/htpasswd-generator).


