provider "libvirt" {
  uri = "qemu:///system"
}

#provider "libvirt" {
#  alias = "server2"
#  uri   = "qemu+ssh://root@192.168.100.10/system"
#}

resource "libvirt_volume" "centos7-qcow2" {
  name = "centos7-disk.qcow2"
  pool = "default"
  source = "https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud.qcow2"
  #source = "./CentOS-7-x86_64-GenericCloud.qcow2"
  format = "qcow2"
}

data "template_file" "user_data" {
  template = "${file("${path.module}/cloud_init.cfg")}"
}

# Use CloudInit to add the instance
resource "libvirt_cloudinit_disk" "commoninit" {
  name = "commoninit.iso"
  user_data = "${data.template_file.user_data.rendered}"
}

# Define KVM domain to create
resource "libvirt_domain" "centos7" {
  name   = "centos7"
  memory = "1024"
  vcpu   = 1

  network_interface {
    network_name = "default"
  }

  disk {
    volume_id = "${libvirt_volume.centos7-qcow2.id}"
  }

  cloudinit = "${libvirt_cloudinit_disk.commoninit.id}"

  console {
    type = "pty"
    target_type = "serial"
    target_port = "0"
  }

  graphics {
    type = "spice"
    listen_type = "address"
    autoport = true
  }
}

