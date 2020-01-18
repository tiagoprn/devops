#!/bin/bash
echo "allowing all in traffic from cni0 interface"
sudo ufw allow in on cni0 from 10.42.0.0/16 comment "K3s rule : https://github.com/rancher/k3s/issues/24#issuecomment-469759329"
echo "Allowing traffic to the Kubernetes API server..."
ufw allow 6443
echo 'The kubelet in the host network needs to be able to send packets "out" via the
weave interface to communicate with pods.'
ufw allow out on weave to 10.32.0.0/12
ufw allow in on weave from 10.32.0.0/12
echo "For multi-node installs open up the tcp and udp ports required for
Weave's control plane and data plane traffic."
ufw allow 6783/udp
ufw allow 6784/udp
ufw allow 6783/tcp
echo "FINISHED!"
