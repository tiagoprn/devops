# Resize the raspbian image file (.img) to 10 GB:

- Ver como rodar comandos na inicialização do raspbian, principalmente os para
  gerar a localização (estou tendo erros de LC_ALL):
https://raspberrypi.stackexchange.com/questions/43550/unable-to-reconfigure-locale-in-raspberry-pi

- Adicionar suporte ao cloud-init na imagem do raspberry, para poder fazer
  bootstrapping mais fácil através do qemu:
[reference-1](https://gist.github.com/RichardBronosky/fa7d4db13bab3fbb8d9e0fff7ea88aa2)

- Usar a abordagem de montar um loop device como [nesse
  link](https://superuser.com/questions/297299/resize-a-partition-image-with-gparted),
ou como nos comandos do `resize-raspbian-img.sh` e usar o fsarchiver com savefs e restfs para
restaurar em um novo arquivo de imagem montado como loopback device.

- [Gerar uma imagem do hypriotos através do cloud-init](https://medium.com/@rvprasad/setting-up-a-raspberry-pi-cluster-2c40cd8e09d6) para bootar através do dockerpi, como alternativa ao raspbian (o hypriotos já vem com um Docker instalado e funcional para o raspberry).

- Bootar a imagem do hypriotos através do dockerpi:
`docker run -d -p 127.0.0.1:5022:5022 -v /myCustomImageWithSshFile.img:/sdcard/filesystem.img lukechilds/dockerpi`

- Solve the TODO mark on `resize-raspbian-img.sh` to allow the process to be totally automated.

Referências adicionais:
https://blog.hypriot.com/post/cloud-init-cloud-on-hypriot-x64/

