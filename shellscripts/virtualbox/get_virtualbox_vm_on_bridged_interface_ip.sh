#!/bin/bash
#
# Translate a MAC address fetched from VirtualBox into a IP address
#

if [  $# -lt 1 ]; then
  echo -e "\nUsage:\n$0 [virtual machine] \n"
  exit 1
fi

# Get a string of the form macaddress1=xxxxxxxxxxx
var1=$(VBoxManage showvminfo $1 --machinereadable |grep macaddress1)

# Asdign macaddress1 the MAC address as a value
eval $var1

# assign m the MAC address in lower case
m=$(echo ${macaddress1}|tr '[A-Z]' '[a-z]')

# This is the MAC address formatted with : and 0n translated into n
mymac=$(echo `expr ${m:0:2}`:`expr ${m:2:2}`:`expr ${m:4:2}`:`expr ${m:6:2}`:`expr ${m:8:2}`:`expr ${m:10:2}`)
echo "The MAC address of the virtual machine $1 is $mymac"

# This runs nmap to scan for all hosts on the network. It will discover all their IPs and MACs.
echo "Running nmap to discover hosts on the network..."
nmap -nsP 10.0.0.0/24

# Use arp to map the IP and mac addresses. It was important to run nmap before because arp can only get info about hosts your machine has already talked to previously.
myip=$(arp -n | grep ${mymac} | awk '{print $1}')
echo "The IP for the mac $mymac is $myip." 

