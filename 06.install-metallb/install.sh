echo -n "[metalLB] Enter Node ip:port : "
read REGISTRY

export METALLB_VERSION=v0.9.3

echo -n "[metalLB] metalLB 대역 설정 [192.168.178.220-192.168.178.222] : "
read ADDRESS_POOL

sed -i 's/v0.9.3/'${METALLB_VERSION}'/g' yaml/metallb.yaml

sed -i 's/metallb\/speaker/'${REGISTRY}'\/metallb\/speaker/g' yaml/metallb.yaml 
sed -i 's/metallb\/controller/'${REGISTRY}'\/metallb\/controller/g' yaml/metallb.yaml 

sed -i 's/{ADDRESS-POOL}/'${ADDRESS_POOL}'/g' yaml/metallb_cidr.yaml 

kubectl apply -f yaml/metallb_namespace.yaml

kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

kubectl apply -f yaml/metallb.yaml
kubectl apply -f yaml/metallb_cidr.yaml