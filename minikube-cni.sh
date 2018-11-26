minikube start --bootstrapper kubeadm --network-plugin cni --extra-config=kubelet.network-plugin=cni

echo "Install Calico by running the following commands"
echo "kubectl apply -f https://docs.projectcalico.org/v3.3/getting-started/kubernetes/installation/hosted/etcd.yaml"
echo "kubectl apply -f https://docs.projectcalico.org/v3.3/getting-started/kubernetes/installation/rbac.yaml"
echo "kubectl apply -f https://docs.projectcalico.org/v3.3/getting-started/kubernetes/installation/hosted/calico.yaml"
echo "Check that all pods are up and running"
echo "kubectl get pods -n kube-system"
