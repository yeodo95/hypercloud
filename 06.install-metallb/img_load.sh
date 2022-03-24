echo -n "[metalLB] Enter Node ip:port : "
read REGISTRY

export METALLB_VERSION=v0.9.3

sudo docker load < img/metallb-controller_${METALLB_VERSION}.tar
sudo docker load < img/metallb-speaker_${METALLB_VERSION}.tar

sudo docker tag metallb/controller:${METALLB_VERSION} ${REGISTRY}/metallb/controller:${METALLB_VERSION}
sudo docker tag metallb/speaker:${METALLB_VERSION} ${REGISTRY}/metallb/speaker:${METALLB_VERSION}

sudo docker push ${REGISTRY}/metallb/controller:${METALLB_VERSION}
sudo docker push ${REGISTRY}/metallb/speaker:${METALLB_VERSION}