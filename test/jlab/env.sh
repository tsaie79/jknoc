#!/bin/bash

export HELM_RELEASE=knoc
export SLURM_CLUSTER_IP=192.168.64.18 
export SLURM_CLUSTER_USER=ubuntu #$(whoami)
# export SLURM_CLUSTER_SSH_PRIV=/home/${SLURM_CLUSTER_USER}/.ssh/id_rsa
export SLURM_CLUSTER_SSH_PRIV=/Users/jeng-yuantsai/.ssh/id_rsa
cd ../..

kubectl create ns argo
kubectl apply -n argo -f deploy/argo-install.yaml


# docker build -t malvag/knoc:latest .

helm upgrade --install --debug --wait $HELM_RELEASE chart/knoc --namespace default \
    --set knoc.k8sApiServer=https://127.0.0.1:51111 \
    --set knoc.remoteSecret.address=${SLURM_CLUSTER_IP} \
    --set knoc.remoteSecret.user=${SLURM_CLUSTER_USER}  \
    --set knoc.remoteSecret.kubeContext=$(kubectl config current-context) \
    --set knoc.remoteSecret.privkey="$(cat ${SLURM_CLUSTER_SSH_PRIV})"    
    # --set knoc.remoteSecret.port=22

kubectl create -f examples/argo-workflow-sample.yaml
