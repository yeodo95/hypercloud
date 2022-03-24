echo -n "[k8s] Enter REGISTRY ip:port : "
read REGISTRY

export NFS_PROVISIONER_VERSION=v4.0.0

sudo docker load < img/nfs_${NFS_PROVISIONER_VERSION}.tar
sudo docker tag gcr.io/k8s-staging-sig-storage/nfs-subdir-external-provisioner:${NFS_PROVISIONER_VERSION} ${REGISTRY}/gcr.io/k8s-staging-sig-storage/nfs-subdir-external-provisioner:${NFS_PROVISIONER_VERSION}
sudo docker push ${REGISTRY}/gcr.io/k8s-staging-sig-storage/nfs-subdir-external-provisioner:${NFS_PROVISIONER_VERSION}