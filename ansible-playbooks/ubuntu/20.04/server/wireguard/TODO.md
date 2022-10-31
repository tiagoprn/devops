- [x] Test the playbook

- [x] Configure my ubuntu host machine from here on:
  <https://linuxize.com/post/how-to-set-up-wireguard-vpn-on-ubuntu-18-04/#linux-and-macos-clients-setup>

- [x] Add this funcionality to the playbook:
  <https://serversideup.net/generating-wireguard-qr-codes-for-fast-mobile-deployments/>
(rename `mobile` on it to `tiago-motorola-android-smartphone` as a variable on
the playbook) - run it on the VM to make sure it is working OK.

- [x] Test `wireguard-client-cookiecutter` on the host to generate qrcodes to
  configurate on the client (check its' `README.md`).

- [x] Test with my android wireguard app on the smartphone

- [ ] Update from this tutorial, it eases the setup for it to be peer-to-peer
  and easily join new nodes:
<https://starbeamrainbowlabs.com/blog/article.php?article=posts/410-cluster-4-wireguard-p2p-vpn.html>


- [ ] Run the playbook on the vm as guest (make sure the guest can ping the
  linode guardian host).

