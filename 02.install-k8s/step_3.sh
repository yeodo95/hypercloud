pushd release/

sed -i'' "s@{imageRegistry}@$REGISTRY@g" ./manifest/yaml/kubeadm-config.yaml
sed -i'' "s@{apiServer}@$MASTER_IP@g" ./manifest/yaml/kubeadm-config.yaml
sed -i'' "s@{serviceSubnet}@$SERVICE_SUBNET@g" ./manifest/yaml/kubeadm-config.yaml
sed -i'' "s@{podSubnet}@$POD_SUBNET@g" ./manifest/yaml/kubeadm-config.yaml

sudo kubeadm init --config=./manifest/yaml/kubeadm-config.yaml

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl get nodes

kubectl get pods -A -o wide

echo -n "[k8s] Master use as worker node? [y/n] : "
read USE_WORKER

if [[ "$USE_WORKER" == "y" ]];
then
   kubectl taint node $HOSTNAME node-role.kubernetes.io/master:NoSchedule-
fi

popd