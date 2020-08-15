# wireguard

This role creates a wireguard VPN on interface `wg0`. It can create a host or a
guest. The keys are located at `/etc/wireguard`.

If you run this playbook to create a guest you must "register" the guest as a
peer on the host after finishing running, so they can communicate. To do that,
login into the host, then e.g.:

```
$ sudo wg set wg0 peer <GUEST_PUBLIC_KEY> allowed-ips <GUEST_VPN_IP>
```

Then, check if both the guest and the host are communicating:

```
$ sudo wg show wg0
```

If you wish to create client configuration e.g. for android clients, you can
use [my wireguard cookiecutter](https://github.com/tiagoprn/wireguard-client-cookiecutter).

# References
- <https://linuxize.com/post/how-to-set-up-wireguard-vpn-on-ubuntu-18-04/#linux-and-macos-clients-setup>
- <https://wiki.archlinux.org/index.php/WireGuard> (specially the "Troubleshooting" section of it)
- <https://websiteforstudents.com/how-to-install-wireguard-vpn-server-on-ubuntu-18-04-20-04/>
- <https://serversideup.net/generating-wireguard-qr-codes-for-fast-mobile-deployments/>
