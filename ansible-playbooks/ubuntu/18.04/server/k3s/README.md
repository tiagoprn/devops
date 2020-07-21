# k3s:

Setup k3s - a production-ready lightweight k8s solution.

It is recommended you run first the `initial-setup` and `docker` playbooks to
provisionate the server. Do not use this with the `monitoring-and-traefik/`,
since they will conflict with each other.

# How to validate k3s is working, deploying a static server:
(see the explanation [here](https://fedoramagazine.org/kubernetes-on-fedora-iot-with-k3s/))
$ kubectl get pods
$ helm repo update
$ kubectl create deployment my-server --image nginx
$ kubectl expose deployment my-server --port 80
$ kubectl get services --all-namespaces
$ curl <ClusterIP from the command above, for the name `my-server`>

# References:
- https://medium.com/@marcovillarreal_40011/cheap-and-local-kubernetes-playground-with-k3s-helm-5a0e2a110de9
- https://www.freshbrewed.science/ubuntu-multipass-better-than-docker/index.html
- https://github.com/rancher/k3s/issues/977
- https://help.replicated.com/community/t/managing-firewalls-with-ufw-on-kubernetes/230
- https://github.com/rancher/k3s/issues/24#issuecomment-469759329
