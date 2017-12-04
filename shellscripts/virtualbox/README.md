## Virtualbox wrappers to automate headless operations

This is a set of shell scripts and a Makefile to make it easier to create a
template VM for Virtualbox from a CentOS 7 cloud image. 

To do that, you can follow these steps: 

### 1) To download a CentOS 7 cloud image, and then convert it to a Virtualbox VM: 

`$ ./download_centos7_cloud_image.sh`

### 2) To create a template Virtualbox VM with the vdi image generated on step [1] above, named e.g. `centos7-template`:

`$ make create vm=centos7-template vdi-file=/home/tiago/distros/images/CentOS-7-x86_64-GenericCloud.template.vdi`

### 3) Create a VM based on the template generated on step [2] above, named e.g. `centos7-01`: 
    
#### A) Generate a cloud-init ISO containing the info to setup the vm:

`$ ./generate_cloud_init_iso.sh centos7-01`

#### B) Create the VM, attaching to it the cloud-init ISO data info from step [A] above: 

`$ ./recreate_vm_with_cloud_init_iso_attached.sh -n centos7-01 -t centos7-template -i ~/distros/images/centos7-01-cloud-init-data.iso`

### 4) Login on the CentOS 7 VM started on step [3B] above, e.g. `centos7-01`: 

#### A) Get the VM IP address to log in: 

`$ ./get_virtualbox_vm_on_bridged_interface_ip.sh`

#### B) Login to the IP address shown by the step [A] above: 

E.g.: 

`$ ssh centos@10.0.0.111`
 
