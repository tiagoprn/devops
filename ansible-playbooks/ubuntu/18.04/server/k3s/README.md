# k3s:

Setup k3s - a production-ready lightweight k8s solution.

It is recommended you run first the `initial-setup` and `docker` playbooks to
provisionate the server. Do not use this with the `monitoring-and-traefik/`,
since they will conflict with each other.


# How to validate k3s is working, deploying a static server:
(see the explanation [here](https://fedoramagazine.org/kubernetes-on-fedora-iot-with-k3s/))

```
$ kubectl get pods
$ helm repo update
$ kubectl create deployment my-server --image nginx
$ kubectl expose deployment my-server --port 80
$ kubectl get services --all-namespaces
$ curl <ClusterIP from the command above, for the name `my-server`>
```

# How to validate k3s local storage is working for pods that need persistance:

```
$ # Get local-path-storage pod is working
$ kubectl -n local-path-storage get pod

$ # Get the local storage provisioner log
$ kubectl -n local-path-storage logs -l app=local-path-provisioner

$ # Test local storage - create persistent volume claim and pod
$ kubectl create -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/examples/pvc.yaml
$ kubectl create -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/examples/pod.yaml

$ # Test local storage - Get persistent volume/+claim info
$ kubectl get pv
$ kubectl get pvc

$ # Test local storage - Get the pod is running
$ kubectl get pod

$ # Test local storage - Write into the pod and then get the contents written
$ kubectl exec volume-test -- sh -c "echo local-path-test > /data/test"
$ kubectl exec volume-test -- sh -c "cat /data/test"

$ # Finish testing - Delete the pod and pvc and check the local provisioner logs full history
$ kubectl delete -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/examples/pod.yaml
$ kubectl delete -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/examples/pvc.yaml
$ kubectl -n local-path-storage logs -l app=local-path-provisioner
```


# Remotely access the cluster **on your local machine** using kubectl

- [Install kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

- Transfer the config file (kubeconfig) to your local machine using ssh:

```
$ scp ubuntu@192.168.122.251:/etc/rancher/k3s/k3s.yaml ~/.kube/config
```

- Replace localhost on the local kube config file with the node IP:

```
$ sed -i 's/127\.0\.0\.1/192\.168\.122\.251/g' ~/.kube/config
```

- Check everything is working:

```
$ kubectl get nodes -o wide
```


# How to access the Kubernetes Dashboard **on your local machine** (allow administering the cluster, like k8s does)

- Login to the cluster using kubectl

- Get the access token at `/opt/containers/k3s/admin-user-dashboard-token.txt`.

- Create a secure channel to your cluster, using kubectl proxy:

`kubectl proxy &`

~~`kubectl proxy --address='0.0.0.0' --port=8001 --accept-hosts='.*'`~~

- Then, open the dashboard:

`xdg-open http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/`


# Notes

- An alternative to k3s can be k3sup.


# References:

- <https://medium.com/@marcovillarreal_40011/cheap-and-local-kubernetes-playground-with-k3s-helm-5a0e2a110de9>
- <https://www.freshbrewed.science/ubuntu-multipass-better-than-docker/index.html>
- <https://github.com/rancher/k3s/issues/977>
- <https://help.replicated.com/community/t/managing-firewalls-with-ufw-on-kubernetes/230>
- <https://github.com/rancher/k3s/issues/24#issuecomment-469759329>
- <https://github.com/rancher/local-path-provisioner/blob/master/README.md#deployment>
- <https://kauri.io/38-install-and-configure-a-kubernetes-cluster-with/418b3bc1e0544fbc955a4bbba6fff8a9/a>
- <https://kauri.io/deploy-prometheus-and-grafana-to-monitor-a-kube/186a71b189864b9ebc4ef7c8a9f0a6b5/a>
