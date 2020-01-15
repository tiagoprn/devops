- youtube videos:
* Part 1: https://www.youtube.com/watch?v=CCfUrWAuxck&list=WL&index=2&t=0s
* Part 2: https://www.youtube.com/watch?v=XIzH7hxTDu8&list=WL&index=3&t=0s
* Part 3: https://www.youtube.com/watch?v=9fGGddwU2w8&list=WL&index=4&t=0s
* Part 4: https://www.youtube.com/watch?v=tgh6mKj2yEw&list=WL&index=5&t=0s
* Part 5: https://www.youtube.com/watch?v=OHDTfJzL6jg&list=WL&index=6&t=0s

- github repository with examples: https://github.com/Praqma/learn-traefik
  (copied on the folder `learn-docker` here)

- providers: can talk to docker or k8s.

- how to install: go to the releases page on github, download the binary and run
with the sample configuration file:
$ ./traefik --configFile=traefik.toml

- frontend is the entrypoint
- backend is to which container it is redirecting to (the one that is responding to it)

- The traefik configurarion for the docker container is also on traefik.toml

- It also provides the following endpoints:
[dashboard](http://localhost:8080)
[traefik api](http://localhost:8080/api)
[traefik healthcheck](http://localhost:8080/health)

- Edit `/etc/hosts` and map the domains that are configured on the `frontend
  host` for each container that is mapped there. E.g.:

```
127.0.0.1 nginx.example.com traefik.example.com tomcat.example.com mysql.example.com
1.1.1.1 nginx.example.com traefik.example.com tomcat.example.com mysql.example.com
```

- traefik is only http, NOT a tcp proxy (check or version 2. MySQL is tcp, not http)

- On the docker-compose file, you set labels for the services you have there.
All services can talk to each other, but just the ones you add the label
`traefik.enable=true` are the ones that get exposed on the traefik dashboard.

- To control the frontend and backend routing, you will also use labels
  on the docker-compose file.

- Container com serviços de rede: `image: praqma/network-multitool:alpine`

- htpasswd generator (para uso com o traefik):
www.htaccesstools.com/htpasswd-generator
ou usar o comando htpasswd: `htpasswd -n -B admin`www.htaccesstools.com/htpasswd-generator




