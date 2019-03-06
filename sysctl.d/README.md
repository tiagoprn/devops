These are kernel configuration parameters to enhance performance on given situations.

They should be copied to `/etc/sysctl.d`. After copying here the changes, you have 2 ways to apply them to your system:

1) Reboot the machine

2) Reload the changes (applies the changes immediately):

    $ sudo sysctl --system

You can verify the current value for a parameter using the same command. E.g.:

    $ sysctl net.core.default_qdisc
    net.core.default_qdisc = fq

    $ sysctl net.ipv4.tcp_congestion_control
    net.ipv4.tcp_congestion_control = bbr


