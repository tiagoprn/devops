# docker

Setup docker daemon and portainer - a web UI to interact with it on a Ubuntu 18.04 server.

It is recommended you run first the `initial-setup` playbook to provisionate
the server.

- All content related to the containers (especially the docker-compose files)
  is located at `/opt/containers`.

- The self-signed TLS certificates to access Portainer are at `/certificates`.

- To access the portainer Web UI to manage containers:

    URL:
    	http://your-host-ip-or-name:9000
	or
	https://your-host-ip-or-name:9443

    user: admin
    password: (enter the one generated at `/opt/containers/portainer/admin.passwd`)

	NOTE: To completely disable http, to use exclusively https: <https://docs.portainer.io/v/ce-2.9/admin/settings#force-https-only>
