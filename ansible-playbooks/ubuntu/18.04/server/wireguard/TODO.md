- [x] Test the playbook

- [x] Configure my ubuntu host machine from here on:
  <https://linuxize.com/post/how-to-set-up-wireguard-vpn-on-ubuntu-18-04/#linux-and-macos-clients-setup>

- [x] Add this funcionality to the playbook:
  <https://serversideup.net/generating-wireguard-qr-codes-for-fast-mobile-deployments/>
(rename `mobile` on it to `tiago-motorola-android-smartphone` as a variable on
the playbook) - run it on the VM to make sure it is working OK.

- [x] Test `wireguard-client-cookiecutter` on the host to generate qrcodes to
  configurate on the client (check its' `README.md`).

- [ ] Use this article as a reference to check my setup:
  <https://www.ckn.io/blog/2017/11/14/wireguard-vpn-typical-setup/`> (there is
an ansible playbook at the end that I could use).

- [ ] Test with my android wireguard app on the smartphone

- [ ] Run the playbook on the vm as guest (make sure the guest can ping the
  linode guardian host).

