pushd ./img
sudo docker load < postgres_${POSTGRES_VERSION}.tar
sudo docker load < hyperauth_b${HYPERAUTH_VERSION}.tar
sudo docker load < zookeeper_${ZOOKEEPER_VERSION}.tar
sudo docker load < kafka_${KAFKA_VERSION}.tar

sudo docker tag postgres:${POSTGRES_VERSION} ${REGISTRY}/postgres:${POSTGRES_VERSION}
sudo docker tag tmaxcloudck/hyperauth:b${HYPERAUTH_VERSION} ${REGISTRY}/hyperauth:b${HYPERAUTH_VERSION}
sudo docker tag wurstmeister/zookeeper:${ZOOKEEPER_VERSION} ${REGISTRY}/zookeeper:${ZOOKEEPER_VERSION}
sudo docker tag wurstmeister/kafka:${KAFKA_VERSION} ${REGISTRY}/kafka:${KAFKA_VERSION}

sudo docker push ${REGISTRY}/postgres:${POSTGRES_VERSION}
sudo docker push ${REGISTRY}/hyperauth:b${HYPERAUTH_VERSION}
sudo docker push ${REGISTRY}/zookeeper:${ZOOKEEPER_VERSION}
sudo docker push ${REGISTRY}/kafka:${KAFKA_VERSION}
popd