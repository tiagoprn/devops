# Resize the raspbian image file (.img) to 10 GB:

- Login via ssh key não está funcionando o user `pi`: usei o script
  `modify-raspbian-img.sh` para nele rodar um comando para copiar a chave ssh
do meu user para o authorized_keys do usuário `pi` no `root/home/pi/.ssh`
montado. Erro:
```
Add sshd configuration...
Add current user ssh pub key to the pi user ssh authorized_keys...
mkdir: cannot create directory ‘root/home/pi/.ssh’: Permission denied
bash: root/home/pi/.ssh/authorized_keys: No such file or directory
```

- Usar a abordagem de montar um loop device como [nesse
  link](https://superuser.com/questions/297299/resize-a-partition-image-with-gparted),
ou como nos comandos do `resize-raspbian-img.sh` e usar o fsarchiver com savefs e restfs para
restaurar em um novo arquivo de imagem montado como loopback device.

- [Gerar uma imagem do hypriotos através do cloud-init](https://medium.com/@rvprasad/setting-up-a-raspberry-pi-cluster-2c40cd8e09d6) para bootar através do dockerpi, como alternativa ao raspbian (o hypriotos já vem com um Docker instalado e funcional para o raspberry). Tenho um script aqui para gerar um cloud-init.

- Bootar a imagem do hypriotos através do dockerpi:
`docker run -d -p 127.0.0.1:5022:5022 -v /myCustomImageWithSshFile.img:/sdcard/filesystem.img lukechilds/dockerpi`

- Solve the TODO mark on `resize-raspbian-img.sh` to allow the process to be totally automated.

Referências adicionais:
https://blog.hypriot.com/post/cloud-init-cloud-on-hypriot-x64/

