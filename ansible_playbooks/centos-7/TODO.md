## INITIAL IMPLEMENTATION

### redash

- [DOING ] Create a self-signed SSL certificate and setup it on the nginx configuration.

- [ ] Adicionar instruções no README de como rodar o stress-ng.  

ex.: $ stress-ng --cpu 1 --vm 1 --hdd 1 --fork 1 --switch 1 --timeout 10 --metrics 


- [ ] After finishing, move
  `/storage/src/devops/ansible_playbooks/centos-7/roles/host_metrics/files/redash`
to my other repository `/storage/src/devops/docker_composes/redash`, since the
redash configuration will be battle-tested. ;) 

## FUTURE ENHANCEMENTS
- Find a way to aggregate all logs into a single place as JSON to later be consolidated on elasticsearch using something like... logstash? 

