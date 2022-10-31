# Raspbian VM powered by Docker

This uses docker to bootstrap qemu and start a VM.

## raspbian

Due to qemu's current limitation, you can only emulate an ARM arquitecture with
32-bit and 256MB of memory.

The raspbian image must be downloaded separately. To enable a non-interactive
VM with ssh enabled (so that you can use ansible e.g.), you must run
`make run-raspbian-ssh` on this folder.

To run an interactive vm, just run `make run-raspbian-interactive` on this folder.

To ssh into the ssh VM, run `make ssh-into-raspbian`.


