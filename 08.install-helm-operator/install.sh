kubectl create namespace helm-ns

kubectl apply -f crds.yaml

kubectl apply -f rbac.yaml

kubectl apply -f deployment.yaml