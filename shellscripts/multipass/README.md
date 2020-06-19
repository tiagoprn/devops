# Multipass

## Instalation
```
$ sudo snap install multipass --classic
```


## Creating a VM
```
$ cd /storage/src/devops/shellscripts/multipass
$ ./generate-cloud-config.sh
$ multipass launch -n ubuntu-lts-custom --cloud-init cloud-config.yaml
```

## Managing VMs
- List: `multipass list`
- Stop: `$ multipass stop <vm>`
- Start: `$ multipass start <vm>`
- Delete: `$ multipass delete <vm>`
- Purge deleted: : `$ multipass purge`

To aid with manual backups of the VMs, take taht into consideration:

- The list of the created instances is at:
```
/var/snap/multipass/common/data/multipassd/multipassd-vm-instances.json
```

- The physical image files are at:
```
/var/snap/multipass/common/data/multipassd/vault
```
