- [ ] Para que o role do suricate seja idempotente, Criar um role 'compute_facts' como sendo o primeiro role do playbook, que detecte se o suricata está instalado
  (só deve rodar o role do suricata se ele já não estiver instalado). Tenho um exemplo de fact no meu playbook do centos.
- [ ] Uncomment the systat role and run it again (it was changed, had an error setting the exectution shellscript
  permission, fixed it, should work now).
- [ ] Após rodar o sysstat role, tirar um backup do container lxc.
- [ ] Create a role to install and configure s3fs and borgbackup (from environment variables).

