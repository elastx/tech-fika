# Tech-Fika
ELASTX Cloud Native Security Tech-Fika
 
We assume that you have some basic Kubenetes knowledge.

# TIPS

Check minikube ip address
```
minkube ip
```

Kubectl auto complete
```
source <(kubectl completion bash)
```

# APP1
## Enable Admission controller

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
## Deploy app with Pod Security Policy

Create namespace
```
kubectl create ns app2
```

Deploy app and service
```
kebectl create -f app2/deployment2.yml
kubectl create -f app2/service2.yml
```

Check status
```
kubectl get deployment -n app2
```

Add Pod Security Policies, Roles and Role Bindings
```
kebectl create -f app2/psp-app2.yml
kebectl create -f app2/rola-app2.yml
kebectl create -f app2/bind-app2.yml
```

Try to deploy again
```
kubectl delete deployment app2 -n app2
kebectl create -f app2/deployment2.yml
```

Check status
```
kubectl get deployment -n app2
kubectl describe pod YOUR_POD_NAME -n app2
```

Try to fix the deployment so it will pass the PSP
```
vi app2/deployment2.yml
kubectl delete deployment app2 -n app2
kebectl create -f app2/deployment2.yml
```


# APP3
## Deploy app with Network Policy

Clear your existing minikube
```
minikube stop
minikube delete
```

Start minikube with kubeadm and Calico cni
```
./minikube-cni.sh
```

Deploy the app
```
kebectl create -f app3/deployment2.yml
kubectl create -f app3/service2.yml
```

Test to connect to the app
```
kubectl describe svc app3-svc -n app3
curl YOUR_MINIKUBE_IP:YOUR_NODE_PORT
```

Apply Network Policy
```
kubectl create -f app3/np-denyingress.yml
```

Test to connect again
```
curl YOUR_MINIKUBE_IP:YOUR_NODE_PORT
```