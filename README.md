# docker-swarm-tests
This repository is about some testing on Docker Swarm, this is not for production ready setup, but mostly to have trace of my testings

I'm trying to setup a three node cluster with Docker Swarm, GlusterFS and using Ansible. I'll try to setup HAProxy, GlusterFS volumes, Keepalived, Galera Cluster and a WordPress website.

Those three nodes have the following specs : 
- 1vCPU
- 2GB RAM
- 32GB Main Drive
- 10GB Second Drive (GlusterFS Share)

I've created on my Ansible manager VM a file containing all hosts :
```
inventory.ini

[swarm]
192.168.40.11
192.168.40.12
192.168.40.13
```

## Creation of the cluster
To begin with, we have to log on our first node to initialize our Swarm. Start with the command `docker swarm init`
This command will return the following command :
```
docker swarm join --token SWMTKN-1-64d8y3n2bkkghzme0u7ribdt2socobnbweg7qism2qip3ojmy6-7s45hhxh4asyun42krusluk1w 192.168.40.11:2377
```

Go on the two other nodes and paste that command to add those nodes to the cluster


## NOT RECOMMANDED - Allow root login by ssh
It's not a recommanded move to do, but for testing, I allow ssh root login on each node. This is not something to do on production
Edit `/etc/ssh/sshd_config` and change `PermitRootLogin` to `yes`


## Setup of ssh key (on Ansible manager VM)
To connect easily to our nodes with Ansible, we have to generate a SSH key and send the public key to each node, and then send it to each node
```
ssh-keygen -t rsa
ssh-copy-id 192.168.40.11
ssh-copy-id 192.168.40.12
ssh-copy-id 192.168.40.13
```


## Installation of Docker on all machines
The installation of Docker on all machines requires some packages first. We'll install `sudo`. Also check that sources for apt are OK (ISO for example can throw an error)
```apt install sudo```

After that, we can run our playbook that will install Docker
```
ansible-playbook -u root -i inventory.ini docker-ce-playbook.yaml
```


## Installation of Keepalived Docker container on all machines

To install Keepalived on each swarm nodes, I can also run the playbook for it. If you try to use it, please replace the virtual IP (VIP) and the interface name in the playbook file
```
ansible-playbook -i inventory.ini keepalived-playbook.yaml
```


## Installation of GlusterFS + volume creation

This step also use a playbook to install GlusterFS, create volumes (only the configs volume ATM) and mount them (+ add entry to fstab file)
```
ansible-playbook -i inventory.ini glusterfs-playbook.yaml
```
