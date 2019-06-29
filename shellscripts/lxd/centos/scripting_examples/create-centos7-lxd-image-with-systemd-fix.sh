#!/bin/bash

# based on: https://github.com/centminmod/centminmod-lxd

lxc profile set default security.syscalls.blacklist "keyctl errno 38"
lxc launch images:centos/7/amd64 centos75-base -s storage_pool -n lxdbr0
lxc exec centos75-base -- echo "export LANG=en_US.UTF-8" >> /etc/profile.d/locale.sh
lxc exec centos75-base -- echo "export LANGUAGE=en_US.UTF-8" >> /etc/profile.d/locale.sh
lxc exec centos75-base -- source /etc/profile.d/locale.sh
lxc exec centos75-base -- sed -i "s|plugins=1|plugins=1\nexclude=\*.i386 \*.i586 \*.i686|" /etc/yum.conf
lxc exec centos75-base -- yum -y update
lxc exec centos75-base -- yum -y install wget openssh openssh-server curl curl-devel libcurl libcurl-devel cloud-init -y
lxc exec centos75-base -- wget https://copr.fedorainfracloud.org/coprs/jsynacek/systemd-backports-for-centos-7/repo/epel-7/jsynacek-systemd-backports-for-centos-7-epel-7.repo -O /etc/yum.repos.d/jsynacek-systemd-centos-7.repo
lxc exec centos75-base -- yum -y update systemd
lxc exec centos75-base -- systemctl enable sshd
lxc exec centos75-base -- systemctl restart sshd
lxc exec centos75-base -- systemctl status sshd

lxc exec centos75-base -- systemctl enable cloud-init-local.service
lxc exec centos75-base -- systemctl enable cloud-init.service
lxc exec centos75-base -- systemctl enable cloud-config.service
lxc exec centos75-base -- systemctl enable cloud-final.service

lxc restart centos75-base
lxc publish centos75-base --alias centos7-systemdfix --force
lxc list
lxc image list
lxc delete centos75-base --force
lxc list


