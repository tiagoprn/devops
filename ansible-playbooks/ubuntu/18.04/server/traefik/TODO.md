Turn `files/traefik.toml` into a jinja2 template, so that I can fill the
htpasswd for the admin user with the result of the following commands:
$ wget https://raw.githubusercontent.com/tiagoprn/devops/master/shellscripts/utils/htpasswd.sh
$ ./htpasswd.sh -u admin -p <ramdomly_generated_password>
$ cat /tmp/htpasswd | grep '\S'
