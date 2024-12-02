To create an authorized system, log into the container and use `mosquitto_passwd` (you may have to comment out the passwd volume to start the container):

```bash
docker compose exec -it mosquitto sh
mosquitto_passwd -c passwd <username>
```