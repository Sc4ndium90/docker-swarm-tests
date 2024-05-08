# Galera Cluster setup

Commands and docker compose file from colinmollenhour/mariadb-galera-swarm Swarm example

```
mkdir -p .secrets
openssl rand -base64 32 > .secrets/xtrabackup_password
openssl rand -base64 32 > .secrets/mysql_password
openssl rand -base64 32 > .secrets/mysql_root_password
docker stack deploy -c docker-compose.yml galera
docker service ls
(wait for `galera_seed` to be healthy)
docker service scale galera_node=2
(wait for both `galera_node` instances to be healthy)
docker service scale galera_seed=0
docker service scale galera_node=3
```
