#!/bin/bash

# Update the systemd-boot loader configuration with custom options
KERNEL_OPTIONS="intel_iommu=on"
LOADER_CONF="/efi/loader/loader.conf"
ENTRIES_DIR="/efi/loader/entries"

# Ensure loader.conf has the required options
if ! grep -q "options ${KERNEL_OPTIONS}" "${LOADER_CONF}"; then
    echo "options ${KERNEL_OPTIONS}" >> "${LOADER_CONF}"
fi

# Update each boot entry
for ENTRY in "${ENTRIES_DIR}"/*.conf; do
    if ! grep -q "${KERNEL_OPTIONS}" "${ENTRY}"; then
        sed -i "/^options / s/$/ ${KERNEL_OPTIONS}/" "${ENTRY}"
    fi
done

# Reboot to apply changes (optional)
# reboot
