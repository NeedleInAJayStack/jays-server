# Mosquitto

- https://hub.docker.com/_/eclipse-mosquitto/
- https://mosquitto.org/documentation/

## Testing Usage

1. Start with `docker-compose up -d`
2. Install client tools locally using `brew install mosquitto` (stop local service with `brew services stop mosquitto`)
3. Set up a listener to the `test/topic`: `mosquitto_sub -t 'test/topic'`
4. From a different terminal, publish to the `test/topic`: `mosquitto_pub -t 'test/topic' -m 'hello world'`