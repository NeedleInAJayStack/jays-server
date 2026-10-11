# Mosquitto

This deploys [Mosquitto](https://mosquitto.org/), and takes inspiration from [this helm chart](https://github.com/SINTEF/mosquitto-helm-chart/tree/main/charts/mosquitto)

## Pasword generation

To create the password, you should use `mosquitto_passwd`:

```bash
FILE=$(mktemp)
mosquitto_passwd -H sha512-pbkdf2 -c $FILE USERNAME  # You will be promted for the password
cut -d ":" -f 2 $FILE
rm $FILE
```
