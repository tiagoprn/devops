"""
Given a KVM machine description file, parse its XML
and change the contents of the nodes "name" and "disk/source.file".

Usage:

python restore_kvm_backup.py \
-x '/kvm/backups/centos7-60/kvm/backups/centos7-60/20180904.0738.04/config.xml' \
-b '/kvm/backups/centos7-60/kvm/backups/centos7-60/20180904.0738.04/centos7-60.qcow2' \
-n 'centos7-60' \
-i '/kvm/images/centos7-60.qcow2';
"""

import argparse
import os
import subprocess
import sys
import xml.etree.ElementTree as et

from time import sleep


cli_parser = argparse.ArgumentParser()
cli_parser.add_argument("-x", "--xml-file", required=True,
                        help="the backup kvm xml configuration file "
                             "containing the machine description.")
cli_parser.add_argument("-b", "--backup-image-file", required=True,
                        help="the full path to the qcow2 image file to be restored")
cli_parser.add_argument("-n", "--vm-name", required=True,
                        help="image name of the vm to show on make status")
cli_parser.add_argument("-i", "--destination-image-file", required=True,
                        help="the full path to where the qcow2 image must be restored")
args = vars(cli_parser.parse_args())

XML_FILE = args['xml_file']
VM_NAME = args['vm_name']
BACKUP_IMAGE_FILE = args['backup_image_file']
IMAGE_FILE = args['destination_image_file']
XML_RESTORATION_FILE = '/tmp/restoration.xml'

if not os.path.exists(XML_FILE):
    print('The backup vm XML config file was not found, impossible to move on.')
    sys.exit(1)

if not os.path.exists(BACKUP_IMAGE_FILE):
    print('The backup image file was not found, impossible to move on.')
    sys.exit(1)


def change_backup_xml_configuration_to_restore_vm():
    tree = et.parse(XML_FILE)
    root = tree.getroot()

    for name in root.iter('name'):
        name.text = VM_NAME

    for disk in root.iter('disk'):
        for child in disk:
            if child.tag == 'source' and child.attrib['file'].endswith('qcow2'):
                child.attrib['file'] = IMAGE_FILE
                break

    tree.write(XML_RESTORATION_FILE)

    print('DONE. The new XML file you must use to restore your VM '
          'is at {}.'.format(XML_RESTORATION_FILE))


if __name__ == "__main__":
    print('Shutting down vm if it is active...')
    subprocess.run(['sudo', 'virsh', 'shutdown', VM_NAME])
    print('Removing existing vm...')
    subprocess.run(['sudo', 'virsh', 'undefine', VM_NAME])
    print('Removing disk for the existing vm...')
    if os.path.exists(IMAGE_FILE):
        os.unlink(IMAGE_FILE)
    print('Changing backup kvm config to restoration...')
    change_backup_xml_configuration_to_restore_vm()
    print('Copying the backup disk as the vm disk...')
    subprocess.run(['sudo', 'cp', '-farv', BACKUP_IMAGE_FILE, IMAGE_FILE])
    print('Restoring vm to the backup image...')
    subprocess.run(['sudo', 'virsh', '-c', 'qemu:///system', 'define', XML_RESTORATION_FILE])
    print('Giving some time before starting the vm...')
    sleep(5)
    print('Starting the restored vm now...')
    subprocess.run(['sudo', 'virsh', '-c', 'qemu:///system', 'start', VM_NAME])
    print('DONE.')
