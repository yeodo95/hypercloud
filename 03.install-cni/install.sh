echo -n "[cni] Enter REGISTRY ip:port : "
read REGISTRY
echo -n "[cni] Enter cni version (v3.16.6): "
read CNI_VERSION
echo -n "[cni] Enter CALICO_IPV4POOL_CIDR (kubeadm-config.yaml podSubnet 대역) : "
read POD_SUBNET


sed -i'' "s@v3.16.6@$CNI_VERSION@g" ./manifest/yaml/calico.yaml
sed -i'' "s@{calico_ipv4pool_cidr}@$POD_SUBNET@g" ./manifest/yaml/calico.yaml
sed -i'' "s@#only-.*@      affinity:\n        nodeAffinity:\n          preferredDuringSchedulingIgnoredDuringExecution:\n          - weight: 1\n            preference:\n              matchExpressions:\n              - key: kubernetes.io/hostname\n                operator: In\n                values:\n                  - $HOSTNAME\n\n          requiredDuringSchedulingIgnoredDuringExecution:\n            nodeSelectorTerms:\n              - matchExpressions:\n                  - key: node-role.kubernetes.io/master\n                    operator: Exists\n@g" ./manifest/yaml/calico.yaml

sed -i 's/calico\/cni/'${REGISTRY}'\/calico\/cni/g' ./manifest/yaml/calico.yaml
sed -i 's/calico\/pod2daemon-flexvol/'${REGISTRY}'\/calico\/pod2daemon-flexvol/g' ./manifest/yaml/calico.yaml
sed -i 's/calico\/node/'${REGISTRY}'\/calico\/node/g' ./manifest/yaml/calico.yaml
sed -i 's/calico\/kube-controllers/'${REGISTRY}'\/calico\/kube-controllers/g' ./manifest/yaml/calico.yaml
sed -i 's/calico\/ctl/'${REGISTRY}'\/calico\/ctl/g' ./manifest/yaml/calicoctl.yaml

kubectl apply -f ./manifest/yaml/calico.yaml
kubectl apply -f ./manifest/yaml/calicoctl.yaml