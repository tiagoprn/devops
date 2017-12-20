#!/bin/bash 

VM_NAME=centos7-01

# TODO: Get the bridge name here from an argument passed by this script 
BRIDGE_NAME=br1

echo 'Downloading the CentOS 7 cloud image...';
bash ./download_centos7_cloud_image.sh;

echo 'Generating the cloud init iso...';
bash ./generate_cloud_init_iso.sh $VM_NAME;

echo 'Preparing the directories which will hold the kvm assets...'
sudo mkdir -p /kvm/templates
sudo mkdir -p /kvm/images
sudo mkdir -p /kvm/iso
sudo chown -R nobody.nobody /kvm && sudo chmod -R 777 /kvm/
cp -farv ~/distros/images/CentOS-7-x86_64-GenericCloud.template.qcow2 /kvm/templates

echo 'Creating a new VM from the image...'
cp -farv /kvm/templates/CentOS-7-x86_64-GenericCloud.template.qcow2 /kvm/images/$VM_NAME.qcow2
./generate_cloud_init_iso.sh $VM_NAME
cp -farv ~/distros/images/$VM_NAME-cloud-init-data.iso /kvm/iso
sudo virt-install --import --name $VM_NAME --ram 1024 --vcpus 1 --disk /kvm/images/$VM_NAME.qcow2,format=qcow2,bus=virtio --disk /kvm/iso/$VM_NAME-cloud-init-data.iso,device=cdrom --network bridge=$BRIDGE_NAME,model=virtio --os-type=linux --os-variant=rhel7 --noautoconsole

echo 'Ejecting the iso created by cloud-init...'
sudo virsh change-media $VM_NAME hda --eject --config 

echo 'FINISHED! Here are the credentials:'
bash ./get_domain_ip.sh $VM_NAME
