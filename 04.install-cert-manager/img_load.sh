echo -n "[cert-manager] Enter Node ip:port : "
read REGISTRY


export CERT_MANAGER_VERSION=v1.5.4
export IMG_CERT_MANAGER_CONTROLLER=quay.io/jetstack/cert-manager-controller:$CERT_MANAGER_VERSION
export IMG_CERT_MANAGER_WEBHOOK=quay.io/jetstack/cert-manager-webhook:$CERT_MANAGER_VERSION
export IMG_CERT_MANAGER_CA_INJECTOR=quay.io/jetstack/cert-manager-cainjector:$CERT_MANAGER_VERSION

sudo docker load < img/controller.tar
sudo docker tag $IMG_CERT_MANAGER_CONTROLLER ${REGISTRY}/jetstack/cert-manager-controller:$CERT_MANAGER_VERSION
sudo docker push ${REGISTRY}/jetstack/cert-manager-controller:$CERT_MANAGER_VERSION

sudo docker load < img/webhook.tar
sudo docker tag $IMG_CERT_MANAGER_WEBHOOK ${REGISTRY}/jetstack/cert-manager-webhook:$CERT_MANAGER_VERSION
sudo docker push ${REGISTRY}/jetstack/cert-manager-webhook:$CERT_MANAGER_VERSION

sudo docker load < img/cainjector.tar
sudo docker tag $IMG_CERT_MANAGER_CA_INJECTOR ${REGISTRY}/jetstack/cert-manager-cainjector:$CERT_MANAGER_VERSION
sudo docker push ${REGISTRY}/jetstack/cert-manager-cainjector:$CERT_MANAGER_VERSION