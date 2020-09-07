# README #

Docker SWARM Wordpress Services for cloud.vanedler.de

### Prerequisite ###

Make sure the proxy_traefik service is running

### Deploy ###

```shell
./deploy.sh
```

### Shutdown ###

To shutdown the stack. This will persist the database, the secrets and the storage.
```shell
./shutdown
```

### Destroy ###

To delete the persistant storage, database and secrets. Optionally with backup.
```shell
./destroy
```

### Links ###

* https://dev.to/ohffs/traefik-v2-with-docker-swarm-2cgh
