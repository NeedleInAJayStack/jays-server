WIP: This is not yet ready to replace Apache! The following issues are still outstanding:

1. The changeover will be difficult because we can only host one on port 80 at a time.
2. Some services use host networking (HomeAssistant), which are difficult to isolate to a docker network.

A few things I discovered about running traefik in a docker container:

1. You need to connect any docker images you'd like it to use using docker networking. The easiest way to do this is to use an external `traefik` network that we connect both to. This is accomplished by running `docker network create traefik`, and must be run before starting any containers.
2. 
