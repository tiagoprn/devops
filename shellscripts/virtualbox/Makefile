help:
	@echo -e "\nHELP:\n"
	@echo -e "make all \n\t List all AVAILABLE vms.\n"
	@echo -e "make ps \n\t List all RUNNING vms.\n"
	@echo -e "make info vm=[name] \n\t Show metadata from a vm.\n"
	@echo -e "make up vm=[name] \n\t START a vm.\n"
	@echo -e "make down vm=[name] \n\t STOP a vm.\n"
	@echo -e "make attach-iso vm=[name] iso-file=[full-iso-file-path] \n\t Attach an ISO file to a VM.\n"
	@echo -e "make dettach-iso vm=[name] \n\t Attach an ISO file to a VM.\n"
	@echo -e "make rm vm=[name] \n\t Removes a vm permanently.\n"
	@echo -e "make clone vm-template=[name] vm=[name] \n\t Create a new vm based on a template.\n"
	@echo -e "make create vm=[name] vdi-file=[full-vdi-file-path] \n\t Create a VM from a vdi file.\n"

all:
	vboxmanage list vms

ps:
	vboxmanage list runningvms

info:
	vboxmanage showvminfo $(vm)

up:
	vboxmanage startvm $(vm) --type headless

down:
	-vboxmanage controlvm $(vm) poweroff

attach-iso: down
	vboxmanage storageattach $(vm) --storagectl IDE --port 0 --device 0 --type dvddrive --medium $(iso-file)

dettach-iso: down
	vboxmanage storageattach $(vm) --storagectl IDE --port 0 --device 0 --medium "none"

rm: down
	vboxmanage unregistervm $(vm) --delete

clone: rm
	vboxmanage clonevm $(vm-template) --name $(vm) --register

create:
	VBoxManage createvm --name $(vm) --register
	VBoxManage modifyvm $(vm) --memory 1024 --acpi on
	VBoxManage modifyvm $(vm) --nic1 bridged --bridgeadapter1 wlp1s0
	VBoxManage modifyvm $(vm) --ostype RedHat
	VBoxManage storagectl $(vm) --name "SATA" --add sata
	VBoxManage storageattach $(vm) --storagectl SATA --port 0 --device 0 --type hdd --medium $(vdi-file)
	VBoxManage storagectl $(vm) --name "IDE" --add ide

