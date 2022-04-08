echo -n "[hyperauth] Enter REGISTRY ip:port : "
read REGISTRY

export POSTGRES_VERSION=9.6.2-alpine
export HYPERAUTH_VERSION=1.1.1.37
export ZOOKEEPER_VERSION=3.4.6
export KAFKA_VERSION=2.12-2.0.1

./img_load.sh

pushd ./manifest
kubectl apply -f strimzi-cluster-operator.yaml
kubectl apply -f 1.initialization.yaml

kubectl apply -f tmaxcloud-issuer.yaml

echo -n "[hyperauth] ssl type? [ip/dns] : "
read NETWORK_CHECK

if [[ "$NETWORK_CHECK" == "ip" ]];
then
  echo -n "[hyperauth] ip address : "
  read IP_ADDRESS
  sed -i'' "s/{HYPERAUTH_EXTERNAL_IP}/"${IP_ADDRESS}"/g" hyperauth_certs_ip.yaml
  kubectl apply -f hyperauth_certs_ip.yaml
else
  echo -n "[hyperauth] dns address : "
  read DNS_ADDRESS
  sed -i'' "s/{HYPERAUTH_EXTERNAL_DNS}/"${DNS_ADDRESS}"/g" hyperauth_certs_dns.yaml
  kubectl apply -f hyperauth_certs_dns.yaml
fi


kubectl get secrets -n hyperauth
kubectl get secret hyperauth-https-secret -n hyperauth -o jsonpath="{['data']['tls\.crt']}" | base64 -d > ./hyperauth.crt
kubectl get secret hyperauth-https-secret -n hyperauth -o jsonpath="{['data']['ca\.crt']}" | base64 -d > ./hypercloud-root-ca.crt
cp ./hyperauth.crt /etc/kubernetes/pki/hyperauth.crt
cp ./hypercloud-root-ca.crt /etc/kubernetes/pki/hypercloud-root-ca.crt

sed -i'' "s/tmaxcloudck/"${REGISTRY}"/g" 2.hyperauth_deployment.yaml
sed -i'' "s/{HYPERAUTH_VERSION}/"${HYPERAUTH_VERSION}"/g" 2.hyperauth_deployment.yaml
kubectl apply -f 2.hyperauth_deployment.yaml
kubectl get svc hyperauth -n hyperauth


popd