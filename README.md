# tech-fika
ELASTX Cloud Native Security Tech-Fika 
We assume that you have some basic Kubenetes knowledge.

# APP1
# Enable Admission controller

Clear your existing minikube
```
minikube stop
minikube delete
```

Start minikube with kubeadm
```
./minikube.sh
```

Add Pod Security Policies, Roles and Role Bindings
```
kubectl create -f app1
```

Restart minikube to enable Admission Controller
```
minikube stop
./minikube-psp.sh
```

Verify that all system pods are started
```
kubectl get bod -n kube-system
```

# APP2
# 

