- [x] Test the playbook

- [x] Configure my ubuntu host machine from here on:
  <https://linuxize.com/post/how-to-set-up-wireguard-vpn-on-ubuntu-18-04/#linux-and-macos-clients-setup>

- [ ] Add this funcionality to the playbook:
  <https://serversideup.net/generating-wireguard-qr-codes-for-fast-mobile-deployments/>
(rename `mobile` on it to `tiago-motorola-android-smartphone` as a variable on
the playbook) - run it on the VM to make sure it is working OK.

- [ ] Delete the current linode guardian and create another with the updated
  mobile generation keys  - run the `initial-setup` and `wireguard` playbooks
only.

- [ ] Test with my android wireguard app on the smartphone

- [ ] Run the playbook on the vm as guest (make sure the guest can ping the
  linode guardian host).

