- [ ] The suricata role has changed, must rerun it to make sure all is working as intended.
- [ ] Uncomment the systat role and run it again (it was changed, had an error setting the exectution shellscript
  permission, fixed it, should work now).
- [ ] After successfully running the sysstat role, make a backup of its lxc container.
- [ ] Create a role to install and configure s3fs and borgbackup (from environment variables).

