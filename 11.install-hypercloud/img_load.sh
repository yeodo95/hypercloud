pushd ./img
sudo docker load < api-server_b${HPCD_API_SERVER_VERSION}.tar
sudo docker tag tmaxcloudck/hypercloud-api-server:b${HPCD_API_SERVER_VERSION} ${REGISTRY}/tmaxcloudck/hypercloud-api-server:b${HPCD_API_SERVER_VERSION}
sudo docker push ${REGISTRY}/tmaxcloudck/hypercloud-api-server:b${HPCD_API_SERVER_VERSION}

sudo docker load < kube-rbac-proxy:v0.5.0.tar
sudo docker tag gcr.io/kubebuilder/kube-rbac-proxy:v0.5.0 ${REGISTRY}/gcr.io/kubebuilder/kube-rbac-proxy:v0.5.0
sudo docker push ${REGISTRY}/gcr.io/kubebuilder/kube-rbac-proxy:v0.5.0

sudo docker load < single-operator_b${HPCD_SINGLE_OPERATOR_VERSION}.tar
sudo docker tag tmaxcloudck/hypercloud-single-operator:b${HPCD_SINGLE_OPERATOR_VERSION} ${REGISTRY}/tmaxcloudck/hypercloud-single-operator:b${HPCD_SINGLE_OPERATOR_VERSION}
sudo docker push ${REGISTRY}/tmaxcloudck/hypercloud-single-operator:b${HPCD_SINGLE_OPERATOR_VERSION}

sudo docker load < multi-operator_b${HPCD_MULTI_OPERATOR_VERSION}.tar
sudo docker tag tmaxcloudck/hypercloud-multi-operator:b${HPCD_MULTI_OPERATOR_VERSION} ${REGISTRY}/tmaxcloudck/hypercloud-multi-operator:b${HPCD_MULTI_OPERATOR_VERSION}
sudo docker push ${REGISTRY}/tmaxcloudck/hypercloud-multi-operator:b${HPCD_MULTI_OPERATOR_VERSION}

sudo docker load < postgres-cron_b${HPCD_POSTGRES_VERSION}.tar
sudo docker tag tmaxcloudck/postgres-cron:b${HPCD_POSTGRES_VERSION} ${REGISTRY}/tmaxcloudck/postgres-cron:b${HPCD_POSTGRES_VERSION}
sudo docker push ${REGISTRY}/tmaxcloudck/postgres-cron:b${HPCD_POSTGRES_VERSION}
popd