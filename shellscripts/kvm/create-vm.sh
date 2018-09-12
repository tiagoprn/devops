#!/bin/bash 

# e.g.
SYNTAX="./create-vm.sh -n [VM_NAME] -b [BRIDGE_NAME] -r [RAM] -c [NUMBER_OF_CPUS]"
HELP="./create-vm.sh -n centos7-02 -b br1 -r 1024 -c 1"

while getopts n:b:r:c: option
do
  case "${option}"
  in
  n) VM_NAME=${OPTARG};;
  b) BRIDGE_NAME=${OPTARG};;
  r) RAM=${OPTARG};;
  c) CPUS=$OPTARG;;
  esac
done

echo 'Parsing script parameters...'
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

VM_IMAGE_FILE=/kvm/images/$VM_NAME.qcow2
if [ -f "${VM_IMAGE_FILE}" ]
then
    # Check for existence of a pubkey, or else exit with message
    echo "[$(date +%r)]----> [ERROR] There is already an image for this VM name. Nothing to be done."
    exit 3
fi

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
cp -farv /kvm/templates/CentOS-7-x86_64-GenericCloud.template.qcow2 $VM_IMAGE_FILE 
./generate_cloud_init_iso.sh $VM_NAME
cp -farv ~/distros/images/$VM_NAME-cloud-init-data.iso /kvm/iso
sudo virt-install --import --name $VM_NAME --ram $RAM --vcpus $CPUS --cpu host --disk /kvm/images/$VM_NAME.qcow2,format=qcow2,bus=virtio --disk /kvm/iso/$VM_NAME-cloud-init-data.iso,device=cdrom --network bridge=$BRIDGE_NAME,model=virtio --os-type=linux --os-variant=rhel7 --noautoconsole

echo 'Ejecting the iso created by cloud-init...'
sudo virsh change-media $VM_NAME hda --eject 
echo 'Removing the iso created by cloud-init, since it will not be necessary anymore...'
sudo rm /kvm/iso/$VM_NAME-cloud-init-data.iso

echo 'Virtual disks attached to the VM:'
sudo virsh domblklist $VM_NAME

echo 'FINISHED! The machine is named' $VM_NAME', has a network bridge at '$BRIDGE_NAME', '$RAM' MB of RAM and uses '$CPUS 'cpu(s). Here are its credentials:'
bash ./get_domain_ip.sh $VM_NAME

