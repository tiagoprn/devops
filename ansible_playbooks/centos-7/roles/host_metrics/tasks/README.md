## On collectd

By default collectd does not collect vmstat data. For it to do that, we must
install a python plugin for vmstat from this repository: https://github.com/signalfx/integrations/tree/master/collectd-vmstat

To start the python plugin, if you do not create a SELinux policy to allow it to run you will have many permission errors. 

To create this policy, do the following (as root): 

```
$ systemctl stop collectd
$ audit2allow -a  # This will tell you which permissions are needed by collectd 
$ audit2allow -a -M cgp  # This will create a policy file with the permissions listed above 
$ semodule -i cgp.pp  # This will apply the policy from the file generated 
$ systemctl start collectd
$ systemctl status collectd
```

Repeat the command above until all permissions errors are gone and the service
finally starts (I had to do that many times until it worked).  

