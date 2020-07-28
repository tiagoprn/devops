## NEXT STEPS

### Test script to redirect a port from the VM to the KVM host:

(original instructions are
[here](https://kauri.io/38-install-and-configure-a-kubernetes-cluster-with/418b3bc1e0544fbc955a4bbba6fff8a9/a)
)

- [ ] Test if redirecting portainer port 9000 to 14601 is working (after
  successful redirection, I should be able to access it from localhost:14601.)
- search for `kvm port` on navi to get the command that manages the
redirections.

- [ ] Write a systemctl unit to run the command `kube proxy` after the k3s
  service is up, and change the playbook to do that instead of just calling the
command `kube proxy`.

- [ ] Test if redirecting kube proxy port 8001 to 14602 is working (after
  successful redirection, I should be able to access it from localhost:14602.)
- search for `kvm port` on navi to get the command that manages the
redirections.


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
