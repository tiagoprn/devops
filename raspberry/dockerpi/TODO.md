- Raise the image file size to at least 10 GB
https://superuser.com/questions/693158/can-i-expand-the-size-of-a-file-based-disk-image/693186
https://superuser.com/questions/297299/resize-a-partition-image-with-gparted

Usar a abordagem de montar um loop device como [nesse
link](https://superuser.com/questions/297299/resize-a-partition-image-with-gparted)
e usar o fsarchiver com savefs e restfs para restaurar em um novo arquivo de
imagem montado como loopback device.

