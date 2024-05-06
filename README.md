# docker-swarm-tests
This repository is about some testing on Docker Swarm, this is not for production ready setup, but mostly to have trace of my testings scripts

I'm trying to setup a three node cluster with Docker Swarm, GlusterFS and using Ansible. It will host a HA web server with nginx as a reverse proxy, haproxy for HA and load balance, keepalived, galera cluster and a wordpress site.

Those three nodes have the following specs : 
- 1vCPU
- 2GB RAM
- 32GB Main Drive
- 10GB Second Drive (GlusterFS Share)
