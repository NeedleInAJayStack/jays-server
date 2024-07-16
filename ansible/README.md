To apply playbook, run:

```sh
ansible-playbook -K -i hosts playbook.yaml
```

## Certbot

To set up and configure Certbot, run:

```sh
ansible-playbook -K -i hosts certbot.yaml
```

Once run, you should be able to SSH in and provision certificates using:

```sh
sudo certbot certonly \
  --dns-cloudflare \
  --dns-cloudflare-credentials '/root/.secrets/cloudflare.ini' \
  -d '*.herron.dev' \
  --preferred-challenges dns-01
```

They will be automatically renewed.