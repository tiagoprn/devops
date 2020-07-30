# kvm-scripts
Useful network scripts for QEMU/KVM
===================================

QEMU/KVM offers powerful networking features, including the ability to create many kinds of networks for your VMs. These can be either an isolated network, a NAT network, or a bridge. There are built-in services that can be configured to serve DNS and DHCP (including PXE support), so you do not need to bother maintaining these services separately, if all you need is basic functionality. Everything is easily editable via libvirt-provided mechanisms, like virt-viewer or virsh.

However, a common problem with QEMU/KVM is how it deals with updates. Many actions, like adding DNS or DHCP entries for a network, will not yield instant results, despite it *looking like it did*. For instance, if you change, for example, an entry for a fixed DHCP host, the change will *not* be reflected until you do the following:
1) do a net-destroy on the network
2) do a net-start on the network
3) reattach the network interface to each VM that was using your network previously (yes, all interfaces are detached... but not reattached until you restart the VM)

Also, there's the port forwarding issue. How do you expose a port to the outside world that goes right into that specific VM? You need a set of iptables rules for this. These rules must be added dynamically, via a hook script. 

The official libvirtd documentation mentions these problems, and offers two example hook scripts (https://wiki.libvirt.org/page/Networking#Applying_modifications_to_the_network). However, their approach is too generic, and uses too many hardcoded values. For example, it tries to reattach interfaces on ALL VMs, even the ones that are not using the network you're modifying. Also, they do not integrate well with each other.

My solution is to rewrite them with the following objectives:

1) easy port forwarding configuration
2) make the process of refreshing the network configuration easy and faster
3) only change the affected VMs/interfaces

Adding port forwards, the easy way
===================================

1. copy and rename the "qemu-hook-script" file to "/etc/libvirt/hooks/qemu". Please note this is a *file* called "qemu", not a directory.

2. modify the file to add your forwarding rules. Adding a port forward is as simple as adding a line like this:

       addForward <VM name> <source port> <destination address> <destination port>

For example, to redirect incoming connections on port 20022 to an internal address of 192.168.101.200 on port 22, whenever the VM named "caasp-admin" is started, you'd write:

    addForward caasp-admin 20022 192.168.101.200 22

3. Set it as executable, or else QEMU/KVM won't call the hook script:

       chmod +x /etc/libvirt/hooks/qemu

The next time you start the VMs listed, the port forwards will be defined properly.

Refreshing network configurations, the easy way
================================================
1. copy the "kvm-network-restart" script to your path (I recommend /usr/sbin).

2. make it an executable:

       chmod +x /usr/sbin/kvm-network-restart
      
and rename the "qemu-hook-script" file to "/etc/libvirt/hooks/qemu". Please note this is a *file* called "qemu", not a directory.

Whenever you change an attribute on a network, say via "virsh net-edit <network>", you can now make the changes available by running "kvm-network-restart <network>".
  
For example, let's say you wanted to reserve an IP address for a specific VM, and add it to the DNS. Just run "virsh net-edit <network name>" and add the following:

    <dns>
      <host ip='192.168.101.200'>
        <hostname>admin.local</hostname>
      </host>
    </dns>
    <ip address='192.168.101.1' netmask='255.255.255.0'>
      <dhcp>
        <range start='192.168.101.128' end='192.168.101.254'/>
        <host mac='52:54:00:26:37:81' name='admin' ip='192.168.101.200'/>
       </dhcp>
    </ip>
  
Then, run "kvm-network-restart <network name>" and you're set.


Doing everything at once: the Python way
========================================

I'm also providing a hook script written in Python, that can be used to do everything in one place. This script receives (and parses) the machine information from stdin, and automatically starts/kills websocket servers for SPICE displays. It also knows how to deal with both iptables and firewalld to add/remove the proper ports.

Just copy the provided qemu-hook-script-python to "qemu" under the /etc/libvirt/hooks directory. Don't forget to chmod +x it. 

Syslog status messages are generated every time you start/stop a VM, just check out journalctl.


Have fun!
