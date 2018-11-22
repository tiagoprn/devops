#!/bin/bash

# Launch a CentOS 7 container with 2 cpus and 2 GB of RAM:
lxc launch images:centos/7/amd64 my-centos -p centos.cloud-init.config -t c2-m2 -s storage_pool -n lxdbr0 -v --debug

lxc exec my-centos -- yum -y update
lxc exec my-centos -- yum -y install wget openssh openssh-server curl curl-devel libcurl libcurl-devel cloud-init -y
lxc exec my-centos -- systemctl enable sshd
lxc exec my-centos -- systemctl enable cloud-init-local.service
lxc exec my-centos -- systemctl enable cloud-init.service
lxc exec my-centos -- systemctl enable cloud-config.service
lxc exec my-centos -- systemctl enable cloud-final.service

lxc stop my-centos

lxc publish my-centos --alias centos-7-with-cloud-init

