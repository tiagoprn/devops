## NEXT STEPS

### Test script to redirect a port from the VM to the KVM host:

- [ ] Test `redirect-port.sh` with portainer port 9000 (after successful redirection, I
  should be able to access it from localhost:9000.)

- [ ] Put the script `redirect-port.sh` on the `terraform-kvm-cookiecutter`
  Makefile, allowing to pass the environment variables as parameters.

- [ ] Map the kubernetes dashboard port 8001 and try to access it from
  localhost - the playbook is finished but the dashboard is not being
accessible from outside, the original instructions are
[here](https://kauri.io/38-install-and-configure-a-kubernetes-cluster-with/418b3bc1e0544fbc955a4bbba6fff8a9/a).
After finished, write a systemctl unit to run the command `kube proxy` after
the k3s service is up, and change the playbook to do that instead of just
calling the command `kube proxy`.


### Install Prometheus and Grafana on the cluster:

- [ ] Through
  [here](https://kauri.io/deploy-prometheus-and-grafana-to-monitor-a-kube/186a71b189864b9ebc4ef7c8a9f0a6b5/a)

---

## FUTURE ENHANCEMENTS

- Install openfaas

- Add elasticsearch for logging:
  <https://www.digitalocean.com/community/tutorials/how-to-set-up-an-elasticsearch-fluentd-and-kibana-efk-logging-stack-on-kubernetes>

---

## OLD

- Update the playbook with these instructions:

Create self-signed certificates to the cluster:
https://tech.paulcz.net/blog/creating-self-signed-certs-on-kubernetes/

(validate with the instructions on README.md)

- Install openfaas:
  https://docs.openfaas.com/deployment/kubernetes/#b-deploy-with-helm-for-production-most-configurable

- Install k9s

- Maybe change to use k3sup? (the link is on my pocket)
