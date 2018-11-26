# Tech-Fika
ELASTX Cloud Native Security Tech-Fika
 
We assume that you have some basic Kubenetes knowledge.

# TIPS

Check minikube ip address
```
minikube ip
```

Check minikube logs
```
minikube logs
```

Login to minikube VM (just if you are curious, you should not need to)
```
minikube ssh
```

Kubectl auto complete
```
source <(kubectl completion bash)
```

# APP1
## Enable Admission Controller

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

Install Calico
```
kubectl apply -f https://docs.projectcalico.org/v3.3/getting-started/kubernetes/installation/hosted/etcd.yaml
kubectl apply -f https://docs.projectcalico.org/v3.3/getting-started/kubernetes/installation/rbac.yaml
kubectl apply -f https://docs.projectcalico.org/v3.3/getting-started/kubernetes/installation/hosted/calico.yaml
```

Check that all system pods are up and running
```
kubectl get pods -n kube-system
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

# APP4
## Image Security check
Login to minikube VM
```
minikube ssh
```

Download Dockerfile
```
curl --create-dirs -o app4/Dockerfile https://raw.githubusercontent.com/elastx/tech/master/app4/Dockerfile
```

Build image
```
docker build -t app4 app4
```

Take a look at the Dockerfile
```
cat app4/Dockerfile
```

Add microscanner and rebuild image
```
sed -i 's/^#//g' app4/Dockerfile
docker build -t app4 app4
```


# APP5
## Image trust

# APP6
## Runtime Security

Install Helm client
https://github.com/helm/helm/releases

Install Tiller
```
kubectl create -f app6/rbac-config.yaml
helm init --service-account tiller
```

Install Falco
```
helm install --name falco --namespace falco -f app6/values.yaml stable/falco
```

Install with sample events generator
```
helm install --name falco --namespace falco -f app6/values.yaml --set fakeEventGenerator.enabled=true stable/falco
```

Install with custom rule sets
```
git clone [https://github.com/draios/falco-extras.git](https://github.com/draios/falco-extras.git)
cd falco-extras
./scripts/rules2helm rules/rules-traefik.yaml rules/rules-redis.yaml > custom-rules.yaml
helm install --name falco -f custom-rules.yaml stable/falco
```
