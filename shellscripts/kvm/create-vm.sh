#!/bin/bash

# e.g.
SYNTAX="./create-vm.sh -d [DISTRO_NAME] -n [VM_NAME] -b [BRIDGE_NAME] -r [RAM] -c [NUMBER_OF_CPUS]"
HELP="./create-vm.sh -d ubuntu20 -n ubuntu20-02 -b br1 -r 1024 -c 1"

while getopts d:n:b:r:c: option
do
  case "${option}"
  in
  d) DISTRO_NAME=${OPTARG};;
  n) VM_NAME=${OPTARG};;
  b) BRIDGE_NAME=${OPTARG};;
  r) RAM=${OPTARG};;
  c) CPUS=$OPTARG;;
  esac
done

echo 'Parsing script parameters...'

if [[ -z $DISTRO_NAME ]]; then
    DISTRO_NAME="ubuntu20"
    printf "Missing -d parameter. I will use $DISTRO_NAME.\n";
fi

if [[ -z $VM_NAME ]]; then
    printf "Missing -n parameter. Syntax: \n\n$SYNTAX\n\nE.g.: \n\n$HELP\n";
    exit 1
fi

if [[ -z $BRIDGE_NAME ]]; then
    printf "Missing -b parameter. Syntax: \n\n$SYNTAX\n\nE.g.: \n\n$HELP\n";
    exit 1
fi

if [[ -z $RAM ]]; then
    RAM=1024
    printf "Missing -r parameter. I will use $RAM MB.\n";
fi

if [[ -z $CPUS ]]; then
    CPUS=1
    printf "Missing -c parameter. I will use $CPUS.\n";
fi

if [ $DISTRO_NAME = "ubuntu18" ]; then
	VM_IMAGE_FILE=/kvm/images/$VM_NAME.img
elif [ $DISTRO_NAME = "ubuntu20" ]; then
	VM_IMAGE_FILE=/kvm/images/$VM_NAME.img
elif [ $DISTRO_NAME = "centos7" ]; then
	VM_IMAGE_FILE=/kvm/images/$VM_NAME.qcow2
fi

if [ -f "${VM_IMAGE_FILE}" ]
then
    # Check for existence of a pubkey, or else exit with message
    echo "[$(date +%r)]----> [ERROR] There is already an image for this VM name. Nothing to be done."
    exit 3
fi

if [ $DISTRO_NAME = "ubuntu18" ]; then
	echo 'Downloading the Ubuntu 18 cloud image...';
	bash ./download_ubuntu18_cloud_image.sh;
elif [ $DISTRO_NAME = "ubuntu20" ]; then
	echo 'Downloading the Ubuntu 20 cloud image...';
	bash ./download_ubuntu20_cloud_image.sh;
elif [ $DISTRO_NAME = 'centos7' ]; then
	echo 'Downloading the CentOS 7 cloud image...';
	bash ./download_centos7_cloud_image.sh;
fi

echo 'Generating the cloud init iso...';
bash ./generate_cloud_init_iso.sh $VM_NAME;

echo 'Preparing the directories which will hold the kvm assets...'
sudo mkdir -p /kvm/templates
sudo mkdir -p /kvm/images
sudo mkdir -p /kvm/iso
sudo chown -R $(id -u).$(id -g)/kvm && sudo chmod -R 777 /kvm/

if [ $DISTRO_NAME = "ubuntu18" ]; then
	cp -farv ~/distros/images/ubuntu-1804-amd64.template.img /kvm/templates
	cp -farv /kvm/templates/ubuntu-1804-amd64.template.img "$VM_IMAGE_FILE"
elif [ $DISTRO_NAME = "ubuntu20" ]; then
	cp -farv ~/distros/images/ubuntu-2004-amd64.template.img /kvm/templates
	cp -farv /kvm/templates/ubuntu-2004-amd64.template.img "$VM_IMAGE_FILE"
elif [ $DISTRO_NAME = "centos7" ]; then
	cp -farv ~/distros/images/CentOS-7-x86_64-GenericCloud.template.qcow2 /kvm/templates
	cp -farv /kvm/templates/CentOS-7-x86_64-GenericCloud.template.qcow2 "$VM_IMAGE_FILE"
fi

echo 'Creating a new VM from the image...'

./generate_cloud_init_iso.sh $VM_NAME
cp -farv ~/distros/images/$VM_NAME-cloud-init-data.iso /kvm/iso


if [ $DISTRO_NAME = "ubuntu18" ]; then
	sudo virt-install --import --name $VM_NAME --ram $RAM --vcpus $CPUS --cpu host --disk /kvm/images/$VM_NAME.img,format=raw,bus=virtio --disk /kvm/iso/$VM_NAME-cloud-init-data.iso,device=cdrom --network bridge=$BRIDGE_NAME,model=virtio --os-type=linux --os-variant=ubuntu18.04 --noautoconsole
elif [ $DISTRO_NAME = "ubuntu20" ]; then
	sudo virt-install --import --name $VM_NAME --ram $RAM --vcpus $CPUS --cpu host --disk /kvm/images/$VM_NAME.img,format=raw,bus=virtio --disk /kvm/iso/$VM_NAME-cloud-init-data.iso,device=cdrom --network bridge=$BRIDGE_NAME,model=virtio --os-type=linux --os-variant=ubuntu20.04 --noautoconsole
elif [ $DISTRO_NAME = "centos7" ]; then
	sudo virt-install --import --name $VM_NAME --ram $RAM --vcpus $CPUS --cpu host --disk /kvm/images/$VM_NAME.qcow2,format=qcow2,bus=virtio --disk /kvm/iso/$VM_NAME-cloud-init-data.iso,device=cdrom --network bridge=$BRIDGE_NAME,model=virtio --os-type=linux --os-variant=rhel7 --noautoconsole
fi

echo 'Ejecting the iso created by cloud-init - first time...'
sudo virsh change-media $VM_NAME hda --eject --config  # --config should not be removed from here, otherwise ssh into the machine will not work.
echo 'Removing the iso created by cloud-init, since it will not be necessary anymore...'
sudo rm /kvm/iso/$VM_NAME-cloud-init-data.iso

echo '==> The machine is named' $VM_NAME', has a network bridge at '$BRIDGE_NAME', '$RAM' MB of RAM and uses '$CPUS 'cpu(s). Here are its credentials:'
bash ./get_domain_ip.sh $VM_NAME

echo 'Ejecting the iso created by cloud-init - final time...' # this updates the registry that generates the dumpxml command, so the backup does not need the iso anymore.
sudo virsh change-media $VM_NAME hda --eject
echo 'Virtual disks attached to the VM:'
sudo virsh domblklist $VM_NAME

echo 'Removing remaining iso files...'
rm -fr ~/distros/images/*.iso

echo 'FINISHED!'
