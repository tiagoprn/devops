- [x] Update versions below (extract to a playbook `vars/main.yml`):
	- [x] prometheus: 2.16.0: <https://github.com/prometheus/prometheus/releases/download/v2.16.0/prometheus-2.16.0.linux-amd64.tar.gz>
	- [x] node_exporter: 0.18.1 <https://github.com/prometheus/node_exporter/releases/download/v0.18.1/node_exporter-0.18.1.linux-amd64.tar.gz>
	- [x] alertmanager: 0.20.0 <https://github.com/prometheus/alertmanager/releases/download/v0.20.0/alertmanager-0.20.0.linux-amd64.tar.gz>

- [ ] Install and integrate Grafana, and add it to traefik.:
	- Baixar a imagem Docker
	- Rodar na porta 3000. Para ter certeza que está executando: `netstat -atunp | grep 3000`
	- Senha default: admin / admin
	- Add DataSource -> Name: Prometheus; Type: Prometheus; URL: [url do prometheus] -> Save & Test
	- Ir para a Home do Grafana -> Find dashboards on grafana.com -> Filter By -> DataSource: prometheus; Search within this list: node exporter -> Node Exporter Full -> Copy ID to Clipboard -> Home do Grafana -> Filter By -> Import Dashboard -> [Colar o ID copiado] -> [Escolher o Datasource] -> Import -> Ir para a Home para ver os dashboards.
(reference: <https://www.youtube.com/watch?v=3K_FkcMwzAk&list=PLf-O3X2-mxDls9uH8gyCQTnyXNMe10iml&index=7>)

