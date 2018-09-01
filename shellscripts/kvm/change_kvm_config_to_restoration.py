"""
Given a KVM machine description file, parse its XML
and change the contents of the nodes "name" and "disk/source.file".

Usage:
python change_kvm_config_to_restoration.py -x 'config.xml' -n 'hello' -i '/kvm/images/centos7-60.qcow2'

"""

import argparse
import os
import sys
import xml.etree.ElementTree as et

cli_parser = argparse.ArgumentParser()
cli_parser.add_argument("-x", "--xml-file", required=True,
                        help="the kvm xml configuration file "
                             "containing the machine description.")
cli_parser.add_argument("-n", "--vm-name", required=True,
                        help="image name of the mv to show on make status")
cli_parser.add_argument("-i", "--image-file", required=True,
                        help="the full path to the qcow2 image file")
args = vars(cli_parser.parse_args())

XML_FILE = args['xml_file']
VM_NAME = args['vm_name']
IMAGE_FILE = args['image_file']
XML_RESTORATION_FILE = '/tmp/restoration.xml'

if not os.path.exists(XML_FILE):
    print('XML file={} does not exist.'.format(XML_FILE))
    sys.exit(1)

if not os.path.exists(IMAGE_FILE):
    print('Image file={} does not exist.'.format(IMAGE_FILE))
    sys.exit(1)

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
