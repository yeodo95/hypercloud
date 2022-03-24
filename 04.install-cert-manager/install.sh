echo -n "[metalLB] Enter Node ip:port : "
read REGISTRY

sed -i "s/quay.io/${REGISTRY}/g" install.yaml

kubectl apply -f install.yaml