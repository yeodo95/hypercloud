pushd manifest/yaml


pushd crd/
kubectl delete -f tmax.io_templates.yaml
kubectl delete -f tmax.io_templateinstances.yaml
kubectl delete -f tmax.io_clustertemplates.yaml
kubectl delete -f tmax.io_clustertemplateclaims.yaml
popd

pushd template-operator/
kubectl delete -f deploy_manager.yaml
kubectl delete -f deploy_rbac.yaml
kubectl delete namespace template
popd

pushd cluster-tsb/
kubectl delete -f tsb_service_broker.yaml
kubectl delete -f tsb_service.yaml
kubectl delete -f tsb_deployment.yaml
kubectl delete -f tsb_rolebinding.yaml
kubectl delete -f tsb_role.yaml
kubectl delete -f tsb_serviceaccount.yaml
kubectl delete namespace cluster-tsb-ns
popd

pushd tsb/
kubectl delete -f tsb_service_broker.yaml
kubectl delete -f tsb_service.yaml
kubectl delete -f tsb_deployment.yaml
kubectl delete -f tsb_rolebinding.yaml
kubectl delete -f tsb_role.yaml
kubectl delete -f tsb_serviceaccount.yaml
kubectl delete namespace tsb-ns
popd

popd
