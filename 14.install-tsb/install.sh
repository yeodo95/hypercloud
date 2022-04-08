echo -n "[tsb] Enter REGISTRY ip:port : "
read REGISTRY

export REGISTRY
export TEMPLATE_VERSION=0.2.7
export TSB_VERSION=0.1.4

chmod +x img_load.sh
./img_load.sh

pushd manifest/yaml

#template-operator install
pushd crd/
kubectl apply -f tmax.io_clustertemplateclaims.yaml
kubectl apply -f tmax.io_clustertemplates.yaml
kubectl apply -f tmax.io_templateinstances.yaml
kubectl apply -f tmax.io_templates.yaml
popd

kubectl create namespace template

pushd template-operator/
kubectl apply -f deploy_rbac.yaml

sed -i'' "s/{imageRegistry}/"${REGISTRY}"/g" deploy_manager.yaml
sed -i'' "s/{templateOperatorVersion}/"${TEMPLATE_VERSION}"/g" deploy_manager.yaml
kubectl apply -f deploy_manager.yaml
popd


#cluster-tsb install
kubectl create namespace cluster-tsb-ns

pushd cluster-tsb/
kubectl apply -f tsb_serviceaccount.yaml 
kubectl apply -f tsb_role.yaml
kubectl apply -f tsb_rolebinding.yaml

sed -i'' "s/{imageRegistry}/"${REGISTRY}"/g" tsb_deployment.yaml
sed -i'' "s/{clusterTsbVersion}/"${TSB_VERSION}"/g" tsb_deployment.yaml
kubectl apply -f tsb_deployment.yaml 

kubectl apply -f tsb_service.yaml
kubectl apply -f tsb_service_broker.yaml
popd

#tsb install
pushd tsb/

kubectl create namespace tsb-ns
kubectl apply -f tsb_serviceaccount.yaml

kubectl apply -f tsb_role.yaml
kubectl apply -f tsb_rolebinding.yaml

sed -i'' "s/{imageRegistry}/"${REGISTRY}"/g" tsb_deployment.yaml
sed -i'' "s/{tsbVersion}/"${TSB_VERSION}"/g" tsb_deployment.yaml
kubectl apply -f tsb_deployment.yaml

kubectl apply -f tsb_service.yaml 

kubectl apply -f tsb_service_broker.yaml
popd

popd
