#!/bin/bash

# REFERENCES:
# https://medium.com/@marcovillarreal_40011/cheap-and-local-kubernetes-playground-with-k3s-helm-5a0e2a110de9
# https://www.freshbrewed.science/ubuntu-multipass-better-than-docker/index.html

echo "----- This MUST be run as root user -----"

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

# # Install helm
# cd /opt/k3s
# curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > install-helm.sh
# chmod u+x install-helm.sh && ./install-helm.sh
# # Link helm with tiller
# ## Create tiller service account
# kubectl -n kube-system create serviceaccount tiller
# ## Create cluster role binding for tiller
# kubectl create clusterrolebinding tiller --clusterrole cluster-admin --serviceaccount=kube-system:tiller
# ## Initialize tiller
# helm init --service-account tiller
# echo -e "FINISHED!"
