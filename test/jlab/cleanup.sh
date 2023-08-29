#!/bin/bash

minikube delete 
kind delete cluster 
docker system prune

rm -rf ~/.minikube
rm -rf ~/.kube

