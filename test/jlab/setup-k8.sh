#!/bin/bash

export MINIKUBE_PROFILE=knoc
export ADVERTISED_HOST=192.168.4.55
export API_SERVER_PORT=8443
export PROXY_API_SERVER_PORT=38080
export KUBE_PROXY=${ADVERTISED_HOST}:${PROXY_API_SERVER_PORT}


minikube start -p ${MINIKUBE_PROFILE} --kubernetes-version=v1.19.13 --apiserver-ips=${ADVERTISED_HOST} --native-ssh=false