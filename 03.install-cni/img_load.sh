echo -n "[k8s] Enter registry ip:port : "
read REGISTRY

export CNI_VERSION=v3.16.6
export CTL_VERSION=v3.16.6

sudo docker load < img/calico-node_${CNI_VERSION}.tar
sudo docker load < img/calico-pod2daemon-flexvol_${CNI_VERSION}.tar
sudo docker load < img/calico-cni_${CNI_VERSION}.tar
sudo docker load < img/calico-kube-controllers_${CNI_VERSION}.tar
sudo docker load < img/calico-ctl_${CTL_VERSION}.tar

sudo docker tag calico/node:${CNI_VERSION} ${REGISTRY}/calico/node:${CNI_VERSION}
sudo docker tag calico/pod2daemon-flexvol:${CNI_VERSION} ${REGISTRY}/calico/pod2daemon-flexvol:${CNI_VERSION}
sudo docker tag calico/cni:${CNI_VERSION} ${REGISTRY}/calico/cni:${CNI_VERSION}
sudo docker tag calico/kube-controllers:${CNI_VERSION} ${REGISTRY}/calico/kube-controllers:${CNI_VERSION}
sudo docker tag calico/ctl:${CTL_VERSION} ${REGISTRY}/calico/ctl:${CTL_VERSION}

sudo docker push ${REGISTRY}/calico/node:${CNI_VERSION}
sudo docker push ${REGISTRY}/calico/pod2daemon-flexvol:${CNI_VERSION}
sudo docker push ${REGISTRY}/calico/cni:${CNI_VERSION}
sudo docker push ${REGISTRY}/calico/kube-controllers:${CNI_VERSION}
sudo docker push ${REGISTRY}/calico/ctl:${CTL_VERSION}