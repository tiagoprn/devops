#!/bin/bash 

# e.g.
# ./create-vm.sh -n centos7-02 -b br1 -r 1024 -c 1

while getopts n:b:r:c: option
do
  case "${option}"
  in
  n) VM_NAME=${OPTARG};;
  b) BRIDGE_NAME=${OPTARG};;
  r) RAM_MB=${OPTARG};;
  c) CPUS=$OPTARG;;
  esac
done

# TODO: set values if any of the variables above was not set

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
sudo virt-install --import --name $VM_NAME --ram $RAM_MB --vcpus $CPUS --disk /kvm/images/$VM_NAME.qcow2,format=qcow2,bus=virtio --disk /kvm/iso/$VM_NAME-cloud-init-data.iso,device=cdrom --network bridge=$BRIDGE_NAME,model=virtio --os-type=linux --os-variant=rhel7 --noautoconsole

echo 'Ejecting the iso created by cloud-init...'
sudo virsh change-media $VM_NAME hda --eject --config 

echo 'FINISHED! Here are the credentials:'
bash ./get_domain_ip.sh $VM_NAME
