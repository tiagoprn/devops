help:
	@echo -e "\nHELP:\n"
	@echo -e "make status \n\t List all vms.\n"
	@echo -e "make nets \n\t Show all networks and their statuses."
	@echo -e "make net-create bridge-name=[brXXX] xml-file=[filename]"
	@echo -e "make ips bridge-name=br1 \n\t List all IPs on a bridged network.\n"
	@echo -e "make ip vm=[name] \n\t Show a VM's IP.\n"
	@echo -e "make info vm=[name] \n\t Show metadata from a vm.\n"
	@echo -e "make up vm=[name] \n\t START a vm.\n"
	@echo -e "make down vm=[name] \n\t STOP a vm.\n"
	@echo -e "make kill vm=[name] \n\t DESTROY a vm.\n"
	@echo -e "make pause vm=[name] \n\t PAUSE a vm.\n"
	@echo -e "make resume vm=[name] \n\t RESUME a vm.\n"
	@echo -e "make enable vm=[name] \n\t AUTO-START a vm.\n"
	@echo -e "make disable vm=[name] \n\t DISABLE AUTO-START on a vm.\n"
	@echo -e "make dettach-iso vm=[name] \n\t Attach an ISO file to a VM.\n"
	@echo -e "make net-attach vm=[name] bridge-name=[brXXX] \n\t Attach a network to a running VM (live).\n"
	@echo -e "make net vm=[name] \n\t Show all network interfaces attached to a VM.\n"
	@echo -e "make rm vm=[name] \n\t Removes a vm permanently.\n"
	@echo -e "make create vm=[name] bridge=[brXXX] ram=712 cpus=1 \n\t Create a VM (you must have a bridge available, use `make nets` to see the ones available).\n"
	@echo -e "make live-backup vm=[name] \n\t Makes a live backup of the VM.\n"

status:
	sudo virsh list --all

nets:
	sudo virsh net-list --all

net-create: 
	sudo virsh net-define $(xml-file)
	sudo virsh net-start $(bridge-name)
	sudo virsh net-autostart $(bridge-name)
	@echo 'Now checking if the bridge was successfully created...'
	sudo brctl show $(bridge-name)
	@echo 'The IP assigned to the bridge is:'
	sudo ip addr show dev $(bridge-name)

ips:
	sudo virsh net-dhcp-leases $(bridge-name)

ip:
	@bash ./get_domain_ip.sh $(vm)

info:
	sudo virsh dominfo $(vm)

up:
	sudo virsh start $(vm)

down:
	-sudo virsh shutdown $(vm)

kill:
	sudo virsh destroy $(vm)

pause:
	sudo virsh suspend $(vm)

resume:
	sudo virsh resume $(vm)

enable:
	sudo virsh autostart $(vm)

disable:
	sudo virsh autostart $(vm) --disable

dettach-iso:
	sudo virsh change-media $(vm) hda --eject --config

net-attach: 
	sudo virsh attach-interface --domain $(vm) --type bridge --source $(bridge-name) --model virtio --config --live

net:
	sudo virsh domiflist $(vm)

rm: down
	sudo virsh undefine $(vm)

create:
	bash ./create-vm.sh -n $(vm) -b $(bridge) -r $(ram) -c $(cpus)

live-backup:
	sudo ./live-backup-vm.sh -n $(vm)

