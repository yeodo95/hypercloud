yum install nfs-utils

git clone -b 5.0 --single-branch https://github.com/yeodo95/hypercloud.git
mv hypercloud/04.install-nfs/provisioner/deploy/ .
rm -rf hypercloud/

echo -n "[nfs] Enter nfs 'namespace' Name : "

read NS
NAMESPACE=${NS:-nfs}

sed -i'' "s/name:.*/name: $NAMESPACE/g" ./deploy/namespace.yaml
sed -i'' "s/namespace:.*/namespace: $NAMESPACE/g" ./deploy/rbac.yaml ./deploy/deployment.yaml

kubectl apply -f deploy/namespace.yaml
kubectl apply -f deploy/rbac.yaml

echo -n "[nfs] Enter nfs server IP : "
read NFS_IP
echo -n "[nfs] Enter nfs exported path : "
read NFS_PATH

sed -i'' "s/192.168.7.16/$NFS_IP/g" ./deploy/deployment.yaml
sed -i'' "s@/mnt/nfs-shared-dir@$NFS_PATH@g" ./deploy/deployment.yaml

kubectl apply -f deploy/deployment.yaml
kubectl apply -f deploy/class.yaml

kubectl patch storageclass nfs -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'