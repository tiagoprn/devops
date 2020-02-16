# Resize the raspbian image file (.img) to 10 GB:

```
$ qemu-img resize -f raw 2020-02-13-raspbian-buster-lite.img +10G
$ sudo udisksctl loop-setup -f disk.img
Mapped file disk.img as /dev/loop0.
$ lsblk
$ resize2fs -p '/dev/loop0p2'  # resize the 2nd partition, the one with the filesystem.
$ sudo udisksctl loop-delete -b /dev/loop0
```

- Usar a abordagem de montar um loop device como [nesse
  link](https://superuser.com/questions/297299/resize-a-partition-image-with-gparted),
ou como nos comandos acima e usar o fsarchiver com savefs e restfs para
restaurar em um novo arquivo de imagem montado como loopback device.

- Gerar uma imagem do hypriotos através do cloud-init para bootar através do dockerpi

- Bootar a imagem do hypriotos através do dockerpi:
`docker run -d -p 127.0.0.1:5022:5022 -v /myCustomImageWithSshFile.img:/sdcard/filesystem.img lukechilds/dockerpi`
