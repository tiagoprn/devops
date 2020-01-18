#!/bin/bash

# REFERENCES:
# https://medium.com/@marcovillarreal_40011/cheap-and-local-kubernetes-playground-with-k3s-helm-5a0e2a110de9
# https://www.freshbrewed.science/ubuntu-multipass-better-than-docker/index.html
# https://github.com/rancher/k3s/issues/977
# https://help.replicated.com/community/t/managing-firewalls-with-ufw-on-kubernetes/230

echo "----- This MUST be run as root user -----"

### FIREWALL RULES:

# allow traffic to the Kubernetes API server
sudo ufw allow 6443
# The kubelet in the host network needs to be able to send packets "out" via the weave interface to communicate with pods.
sudo ufw allow out on weave to 10.32.0.0/12
sudo ufw allow in on weave from 10.32.0.0/12
# For multi-node installs open up the tcp and udp ports required for Weave's control plane and data plane traffic.
sudo ufw allow 6783/udp
sudo ufw allow 6784/udp
sudo ufw allow 6783/tcp


### PART 1

echo -e "STARTING INSTALLATION..."
mkdir /opt/k3s
cd /opt/k3s
curl -sfL https://get.k3s.io | sh -
echo "Enable a normal user to use k3s..."
echo 'K3S_KUBECONFIG_MODE="644"' >> /etc/systemd/system/k3s.service.env
echo "Restarting service..."
systemctl stop k3s
systemctl start k3s
echo "Check if k3s is working..."
kubectl get nodes
kubectl get po -n kube-system
echo "Create a storage class for your cluster..."
kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml
echo "Checking storage class..."
kubectl get storageclass

### PART 2

# Install helm
cd /opt/k3s
curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > install-helm.sh
chmod u+x install-helm.sh && ./install-helm.sh
# Link helm with tiller
## Create tiller service account
kubectl -n kube-system create serviceaccount tiller
## Create cluster role binding for tiller
kubectl create clusterrolebinding tiller --clusterrole cluster-admin --serviceaccount=kube-system:tiller
## Copy kubeconfig
mkdir -p /home/ubuntu/.kube/ && chown -R ubuntu.ubuntu /home/ubuntu/.kube/
mkdir -p /home/ops/.kube/ && chown -R ops.ops /home/ops/.kube/
cp /etc/rancher/k3s/k3s.yaml /home/ubuntu/.kube/config && chmod 644 /home/ubuntu/.kube/config
cp /etc/rancher/k3s/k3s.yaml /home/ops/.kube/config && chmod 644 /home/ops/.kube/config
## Initialize tiller
# (important: must be done as a normal user)
# su - ubuntu
# helm init --service-account tiller
echo -e "FINISHED!"
