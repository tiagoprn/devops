# Raspbian VM powered by Docker

This uses docker to bootstrap qemu and start a raspbian VM.

Due to qemu's current limitation, you can only emulate an ARM arquitecture with
32-bit and 256MB of memory.

The raspbian image must be downloaded separately. To enable a non-interactive
VM with ssh enabled (so that you can use ansible e.g.), you must run the
`mount-raspbian...` script on this folder, setting your raspbian image file as
an environment variable. This will create a ssh file on /boot, so that the ssh
server will be automatically started on boot.

The run command on the Makefile exposes the raspbian vm on port 5022 of
localhost, so that you can ssh into it like:

`$ ssh pi@localhost -p 5022`

So, if you need more VMs, just change the exposed port on the host to other
numbers. ;)

