While developing, it is helpful to switch back and forth between nginx and apache to validate. To do so:

```sh
sudo systemctl stop apache2.service
docker-compose up
```
