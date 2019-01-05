curl https://archive.archlinux.org/packages/l/linux-lts/linux-lts-4.14.90-1-x86_64.pkg.tar.xz -o  linux-lts-4.14.90-1-x86_64.pkg.tar.xz
curl https://archive.archlinux.org/packages/l/linux-lts-headers/linux-lts-headers-4.14.90-1-x86_64.pkg.tar.xz -o linux-lts-headers-4.14.90-1-x86_64.pkg.tar.xz
curl https://archive.archlinux.org/packages/l/linux-lts/linux-lts-4.14.90-1-x86_64.pkg.tar.xz.sig -o linux-lts-4.14.90-1-x86_64.pkg.tar.xz.sig
curl https://archive.archlinux.org/packages/l/linux-lts-headers/linux-lts-headers-4.14.90-1-x86_64.pkg.tar.xz.sig -o linux-lts-headers-4.14.90-1-x86_64.pkg.tar.xz.sig
pacman -U *.xz

