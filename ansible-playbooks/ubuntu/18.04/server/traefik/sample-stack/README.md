# Pre-requisites

## Map your local IPs to match domains that will be used on traefik

Run the script to configure your local dns:

`$ sudo ./local_dns.sh`.

## Generate the SSL certificates:

`./generate-self-signed-certs.sh`

## Run the docker-compose:

`docker-compose stop && docker-compose rm -f && docker-compose up -d`

## The traefik dashboard

The credentials to enter traefik dashboard are:

`admin / 12345678`

This user/password combination is configured on `traefik.toml`, at `entryPoints.dashboard.auth.basic`. To generate the string containing the password, you must use `htpasswd`, e.g.:

`$ htpasswd -n -B admin`

, or an [online htpasswd generator](http://www.htaccesstools.com/htpasswd-generator).


## ansible playbook tasks to download and create tls certificates

```
- name: Download the script to generate the tls certificates
  get_url:
    url: https://raw.githubusercontent.com/tiagoprn/devops/master/shellscripts/utils/certificates/create-csr-and-private-key.sh
    dest: /opt
    mode: 0744

- name: Generate the TLS certificates
  command: bash /opt/create-csr-and-private-key.sh -o certs
```
