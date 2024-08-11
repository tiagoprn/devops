Here are some scripts I needed to fully enable virtualization on EndeavourOS.

They were needed to update kernel boot parameters to fully enable the virtualization.

- <./boot/90-systemd-boot.hook>:
    - This is a hook that is triggered on pacman when there are kernel updates
    - It must be copied to </etc/pacman.d/hooks/90-systemd-boot.hook>

- <./boot/update-systemd-boot.sh>:
    - This is a script that updates the boot entries with the `intel_iommu` kernel parameter.
    - It must be copied to </usr/local/bin/update-systemd-boot.sh>

- After copying those script to the destinations above, you must:
    - run </usr/local/bin/update-systemd-boot.sh>
    - restart the machine
    - run `sudo virt-host-validate` and make sure `iommu` is checked
