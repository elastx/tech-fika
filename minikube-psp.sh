#!/usr/bin/env bash
minikube start --bootstrapper kubeadm --extra-config=apiserver.admission-control=Initializers,NamespaceLifecycle,LimitRanger,ServiceAccount,DefaultStorageClass,DefaultTolerationSeconds,NodeRestriction,ResourceQuota,MutatingAdmissionWebhook,ValidatingAdmissionWebhook,PodSecurityPolicy
