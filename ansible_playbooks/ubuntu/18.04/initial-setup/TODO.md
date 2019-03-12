- [ ] Check dashboards that are not being populated with data - must be activated or configured on collectd.conf (https://10.0.10.96/dashboards?page=1&page_size=20&order=-created_at)
      IMPORTANT: edit in real-time inside the container until all information is rendered, and then copy the new collectd.conf inside this git repo.
      - Dashboards:
        - [ ] Disks
        - [ ] Critical processes metrics (docker and collectd)
            - [ ] Revisar as queries que estão sendo feitas no Redash (por exemplo, em `processes_read`, o valor da coluna `type`
                  está diferente em SHOW MEASUREMENTS no influx versus o que está na query do redash - alterar essas queries diretamente no backup que é restaurado das queries do postgres ao restaurar a dashboard).

- [ ] configure mitogen to run faster commands on playbooks according to (document on tiagopr.nl also): https://mitogen.readthedocs.io/en/latest/ansible.html
- [ ] Create a role to install and configure s3fs and borgbackup (from environment variables).
- [ ] On each role, add a README.md briefly explaining what it does.

NOTE: until the cleanup role (with collectd and influxdb enabled), the load of the machine keeps low and the memory consuption at around 450 MB only.
