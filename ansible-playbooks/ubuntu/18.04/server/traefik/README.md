# Traefik

Setup traefik - a simple reverse proxy supporting container workflows.

It is recommended you run first the `initial-setup` playbook to provisionate
the server.

The folder `sample-stack` here has traefik configurations. One of them has the
option to use letsencrypt certificates.

# ABOUT

Here we have a docker-compose containing 3 components:

- traefik: to serve 2 backend apps (nginx and tomcat)
- nginx: a static site
- tomcat: a java app server
- mysql: a database. Since it is tcp and not http, it cannot be used on traefik
  1.0 (although 2.0 supports tcp apps).


Traefik has an admin dashboard which is protected by an http simple auth. To
access it, see the apropriate section below.

Traefik, nginx and tomcat can all be accessed through https (the tls
certificates are configured on traefik). They respond on the domain
"example.com", that must be mapped on your local machine on `/etc/hosts` (below
are the instructions to automate that also).


# Pre-requisites

## Map your local IPs to match domains that will be used on traefik

Run the script to configure your local dns:

`$ sudo ./local_dns.sh`.

## Generate the SSL certificates:

`./generate-self-signed-certs.sh`

## Run the docker-compose:

`docker-compose stop && docker-compose rm -f && docker-compose up -d`

## The traefik dashboard

URL: https://traefik.example.com
user/password: `admin / 12345678`

This user/password combination is configured on `traefik.toml`, at `entryPoints.dashboard.auth.basic`. To generate the string containing the password, you must use `htpasswd`, e.g.:

`$ htpasswd -n -B admin`

, or an [online htpasswd generator](http://www.htaccesstools.com/htpasswd-generator).

