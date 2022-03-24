kubectl delete -f deploy/class.yaml
kubectl delete -f deploy/deployment.yaml
kubectl delete -f deploy/rbac.yaml
kubectl delete -f deploy/namespace.yaml

rm -rf deploy/