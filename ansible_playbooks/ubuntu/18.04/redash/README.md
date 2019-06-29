# Ubuntu 18.04 provisioning playbook

This is a modular ansible playbook, which can be used to setup a new Ubuntu 18.04 server instance with redash installed.
As a prerequisite, you must have run before the playbook `initial-setup` from this repository.

## Important:

- Specially due to the fact that this scripts installs a local
postgres database for redash, it it recommended that it runs on machines/VMs with
2GB+ of RAM for it to finish successfully. I had errors running it on a 1GB RAM
VM with exit code 137 on the setup_redash_container task, due to that fact.

- All content related to the containers (especially the docker-compose files) is located at `/opt/containers`.

- The self-signed TLS certificates to access Redash are at `/certificates`.

- To access the redash web UI to see the system metrics:

    URL: https://your-ubuntu-host-ip-or-name
    email: devops@localhost.localdomain
    password: admin12345678 (change it as soon as possible)


