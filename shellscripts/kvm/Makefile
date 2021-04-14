.PHONY: help status nets

SHELL := /bin/bash
PROJECT_ROOT=$(shell pwd)

help:  ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

status:  ## List all vms
	sudo virsh list --all

nets:  ## Show all networks and their statuses
	sudo virsh net-list --all

net-create:  ## Creates a virtual network. E.g.: make net-create bridge-name=br1 xml-file=conf/kvm-nat-network.xml
	sudo virsh net-define $(xml-file)
	sudo virsh net-start $(bridge-name)
	sudo virsh net-autostart $(bridge-name)
	@echo 'Now checking if the bridge was successfully created...'
	sudo brctl show $(bridge-name)
	@echo 'The IP assigned to the bridge is:'
	sudo ip addr show dev $(bridge-name)

ips:  ## List all IPs on a bridged network. E.g. make ips bridge-name=br1
	sudo virsh net-dhcp-leases $(bridge-name)

ip:  ## Show a VM's IP. E.g. make ip vm=[name]
	@bash ./get_domain_ip.sh $(vm)

info:  ## Show metadata from a vm. E.g. make info vm=[name]
	sudo virsh dominfo $(vm)

up:  ## START a vm. E.g. make up vm=[name]
	sudo virsh start $(vm)

down:  ## STOP a vm. E.g. make down vm=[name]
	-sudo virsh shutdown $(vm)

kill:  ## DESTROY a vm. E.g. make kill vm=[name]
	sudo virsh destroy $(vm)

pause:  ## PAUSE a vm. E.g. make pause vm=[name]
	sudo virsh suspend $(vm)

resume:  ## RESUME a vm. E.g. make resume vm=[name]
	sudo virsh resume $(vm)

enable:  ## AUTO-START a vm. E.g. make enable vm=[name]
	sudo virsh autostart $(vm)

disable:  ## DISABLE AUTO-START on a vm. E.g. make disable vm=[name]
	sudo virsh autostart $(vm) --disable

dettach-iso:  ## Attach an ISO file to a VM. E.g. make dettach-iso vm=[name]
	sudo virsh change-media $(vm) hda --eject --config

net-attach:  ## Attach a network to a running VM (live). E.g. make net-attach vm=[name] bridge-name=br1
	sudo virsh attach-interface --domain $(vm) --type bridge --source $(bridge-name) --model virtio --config --live

net:  ## Show all network interfaces attached to a VM. E.g. make net vm=[name]
	sudo virsh domiflist $(vm)

rm: down  ## Removes a vm permanently. E.g. make rm vm=[name]
	sudo virsh undefine $(vm) --snapshots-metadata

create:  ## Create a VM (you must have a bridge available, use `make nets` to see the ones available). E.g. make create distro_name=ubuntu18 vm=[name] bridge=br1 ram=712 cpus=1
	bash ./create-vm.sh -d $(distro_name) -n $(vm) -b $(bridge) -r $(ram) -c $(cpus)

live-backup:  ## Makes a live backup of the VM. E.g. make live-backup vm=[name]
	sudo ./live-backup-vm.sh -n $(vm)
