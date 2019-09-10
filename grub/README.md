# INSTRUCTIONS

To boot these arch and systemrescuecs grub entries (which nowadays are both in fact python), you
must have the `/boot` directory on a partition with the `ROOT` label (you must have `/boot/efi` on
another partition with another label, no problems with that).  The iso files `systemrescuecd.iso`
and `archlinux.iso` must be on `/boot`.

To boot ubuntu grub entry, you must have the ubuntu iso file on a partition with the `STORAGE`
label, and the iso file on `/grub_isos`.

**IMPORTANT**: When you update the Arch linux monthly install ISO, update the variable
`arch_iso_label` on `26_arch_install` accordingly.

These files that start with numbers must be copied to `/etc/grub.d`, and to dinamically generate
the updated grub menu with them you must:

    $ grub-mkconfig -o /boot/grub/grub.cfg

