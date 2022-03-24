pushd ./img
sudo docker load < postgres_${POSTGRES_VERSION}.tar
sudo docker load < hyperauth_b${HYPERAUTH_VERSION}.tar

sudo docker tag postgres:${POSTGRES_VERSION} ${REGISTRY}/postgres:${POSTGRES_VERSION}
sudo docker tag tmaxcloudck/hyperauth:b${HYPERAUTH_VERSION} ${REGISTRY}/hyperauth:b${HYPERAUTH_VERSION}

sudo docker push ${REGISTRY}/postgres:${POSTGRES_VERSION}
sudo docker push ${REGISTRY}/hyperauth:b${HYPERAUTH_VERSION}
popd