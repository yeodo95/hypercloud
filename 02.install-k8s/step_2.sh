sudo yum install -y docker-ce
sudo systemctl start docker
sudo systemctl enable docker

sudo yum install -y kubeadm-1.19.4-0 kubelet-1.19.4-0 kubectl-1.19.4-0
 
sudo systemctl enable kubelet