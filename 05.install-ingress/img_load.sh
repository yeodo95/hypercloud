echo -n "[ingress] Enter Node ip:port : "
read REGISTRY

export NGINX_INGRESS_CONTROLLER_VERSION=0.33.0
export KUBE_WEBHOOK_CRETGEN_VERSION=v1.2.2

docker load < img/nginx.tar
sudo docker tag quay.io/kubernetes-ingress-controller/nginx-ingress-controller:$NGINX_INGRESS_CONTROLLER_VERSION   ${REGISTRY}/kubernetes-ingress-controller/nginx-ingress-controller:$NGINX_INGRESS_CONTROLLER_VERSION
docker push ${REGISTRY}/kubernetes-ingress-controller/nginx-ingress-controller:$NGINX_INGRESS_CONTROLLER_VERSION

docker load < img/webhook.tar
sudo docker tag docker.io/jettech/kube-webhook-certgen:$KUBE_WEBHOOK_CRETGEN_VERSION   ${REGISTRY}/jettech/kube-webhook-certgen:$KUBE_WEBHOOK_CRETGEN_VERSION
docker push ${REGISTRY}/jettech/kube-webhook-certgen:$KUBE_WEBHOOK_CRETGEN_VERSION
