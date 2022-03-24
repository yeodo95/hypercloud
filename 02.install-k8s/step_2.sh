pushd release/

sudo yum install -y docker-ce
sudo systemctl start docker
sudo systemctl enable docker

 sudo yum install -y kubeadm-1.19.4-0 kubelet-1.19.4-0 kubectl-1.19.4-0
 
 sudo systemctl enable kubelet

sed -i'' "s@{imageRegistry}@$REGISTRY@g" ./manifest/yaml/kubeadm-config.yaml

sed -i'' "s@{imageRegistry}@$REGISTRY@g" ./manifest/yaml/kubeadm-config.yaml
sed -i'' "s@{apiServer}@$MASTER_IP@g" ./manifest/yaml/kubeadm-config.yaml
sed -i'' "s@{serviceSubnet}@$SERVICE_SUBNET@g" ./manifest/yaml/kubeadm-config.yaml
sed -i'' "s@{podSubnet}@$POD_SUBNET@g" ./manifest/yaml/kubeadm-config.yaml

sudo kubeadm init --config= ./manifest/yaml/kubeadm-config.yaml

popd