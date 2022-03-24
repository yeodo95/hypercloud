echo -n "[k8s] Enter registry ip:port : "
read REGISTRY

pushd ./img

sudo docker load -i kube-apiserver.tar
sudo docker load -i kube-scheduler.tar
sudo docker load -i kube-controller-manager.tar 
sudo docker load -i kube-proxy.tar
sudo docker load -i etcd.tar
sudo docker load -i coredns.tar
sudo docker load -i pause.tar

popd

sudo docker tag k8s.gcr.io/kube-apiserver:v1.19.4 ${REGISTRY}/k8s.gcr.io/kube-apiserver:v1.19.4
sudo docker tag k8s.gcr.io/kube-proxy:v1.19.4 ${REGISTRY}/k8s.gcr.io/kube-proxy:v1.19.4
sudo docker tag k8s.gcr.io/kube-controller-manager:v1.19.4 ${REGISTRY}/k8s.gcr.io/kube-controller-manager:v1.19.4
sudo docker tag k8s.gcr.io/etcd:3.4.13-0 ${REGISTRY}/k8s.gcr.io/etcd:3.4.13-0
sudo docker tag k8s.gcr.io/coredns:1.7.0 ${REGISTRY}/k8s.gcr.io/coredns:1.7.0
sudo docker tag k8s.gcr.io/kube-scheduler:v1.19.4 ${REGISTRY}/k8s.gcr.io/kube-scheduler:v1.19.4
sudo docker tag k8s.gcr.io/pause:3.2 ${REGISTRY}/k8s.gcr.io/pause:3.2

sudo docker push ${REGISTRY}/k8s.gcr.io/kube-apiserver:v1.19.4
sudo docker push ${REGISTRY}/k8s.gcr.io/kube-proxy:v1.19.4
sudo docker push ${REGISTRY}/k8s.gcr.io/kube-controller-manager:v1.19.4
sudo docker push ${REGISTRY}/k8s.gcr.io/etcd:3.4.13-0
sudo docker push ${REGISTRY}/k8s.gcr.io/coredns:1.7.0
sudo docker push ${REGISTRY}/k8s.gcr.io/kube-scheduler:v1.19.4
sudo docker push ${REGISTRY}/k8s.gcr.io/pause:3.2

curl ${REGISTRY}/v2/_catalog
