- [ ] Update collectd role to install version 5.8 (from ubuntu repos installed 5.7, which has some processes plugin e.g. metrics renamed
                                                   from 5.8 which is what I used on CentOS).
        - [ ] Update the role to download and install from below (and on the sequence below) and NOT the outdated version from the official repository:
            http://mirrors.kernel.org/ubuntu/pool/universe/c/collectd/collectd-core_5.8.0-5.2_amd64.deb
            http://mirrors.kernel.org/ubuntu/pool/universe/c/collectd/collectd_5.8.0-5.2_amd64.deb

        Here is what changed on 5.8 (that is why 5.7 did not find some metrics):
            (https://collectd.org/wiki/index.php/Version_5.8)
            Processes plugin: The I/O operations reported for selected processes has been fixed. The metric ps_disk_octets has been renamed to io_octets because it actually contains the number of I/O operation by the process, not just disk related I/O. Same for io_ops (previously ps_disk_ops). The new metric disk_octets has been added and is reporting disk I/O only. Add option to collect the count of active memory maps for Linux processes. The CollectFileDescriptor and CollectContextSwitch options have been added. Thanks to Pavel Rochnyack and to Wilfried Goesgens. #2232, #2454, #1989

- [ ] Check dashboards that are not being populated with data - must be activated or configured on collectd.conf (https://10.0.10.96/dashboards?page=1&page_size=20&order=-created_at)
      IMPORTANT: edit in real-time inside the container until all information is rendered, and then copy the new collectd.conf inside this git repo.
      - Dashboards:
        - [ ] Disks
        - [ ] Critical processes metrics (docker and collectd)

- [ ] configure mitogen to run faster commands on playbooks according to (document on tiagopr.nl also): https://mitogen.readthedocs.io/en/latest/ansible.html
- [ ] Create a role to install and configure s3fs and borgbackup (from environment variables).
- [ ] On each role, add a README.md briefly explaining what it does.

NOTE: until the cleanup role (with collectd and influxdb enabled), the load of the machine keeps low and the memory consuption at around 450 MB only.
