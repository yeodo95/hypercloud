echo -n "[ingress] Enter Node ip:port : "
read REGISTRY

export NGINX_INGRESS_VERSION=0.33.0
export KUBE_WEBHOOK_CERTGEN_VERSION=v1.2.2
export INGRESS_NGINX_NAME=ingress-nginx-system

sed -i 's/ingress-nginx/'${INGRESS_NGINX_NAME}'/g' yaml/system.yaml
sed -i 's/{nginx_ingress_version}/'${NGINX_INGRESS_VERSION}'/g' yaml/system.yaml
sed -i 's/{kube_webhook_certgen_version}/'${KUBE_WEBHOOK_CERTGEN_VERSION}'/g' yaml/system.yaml

export INGRESS_NGINX_NAME=ingress-nginx-shared

sed -i 's/ingress-nginx/'${INGRESS_NGINX_NAME}'/g' yaml/shared.yaml
sed -i 's/{nginx_ingress_version}/'${NGINX_INGRESS_VERSION}'/g' yaml/shared.yaml
sed -i 's/{kube_webhook_certgen_version}/'${KUBE_WEBHOOK_CERTGEN_VERSION}'/g' yaml/shared.yaml

sed -i 's/quay.io\/kubernetes-ingress-controller\/nginx-ingress-controller/'${REGISTRY}'\/kubernetes-ingress-controller\/nginx-ingress-controller/g' yaml/system.yaml
sed -i 's/docker.io\/jettech\/kube-webhook-certgen/'${REGISTRY}'\/jettech\/kube-webhook-certgen/g' yaml/system.yaml

sed -i 's/quay.io\/kubernetes-ingress-controller\/nginx-ingress-controller/'${REGISTRY}'\/kubernetes-ingress-controller\/nginx-ingress-controller/g' yaml/shared.yaml
sed -i 's/docker.io\/jettech\/kube-webhook-certgen/'${REGISTRY}'\/jettech\/kube-webhook-certgen/g' yaml/shared.yaml

kubectl apply -f yaml/system.yaml
kubectl apply -f yaml/shared.yaml