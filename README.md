# Jay's Server

This repo centralizes the docker run configuration for many of the services I run on my server.

## Kubernetes

I currently use Minikube to run Kubernetes locally. To run it, do:

minikube start --mount --mount-string="/opt/minikube:/opt/minikube"