pushd ./img

sudo docker load < template-operator_0.2.7.tar
sudo docker tag tmaxcloudck/template-operator:0.2.7 ${REGISTRY}/tmaxcloudck/template-operator:0.2.7
sudo docker push ${REGISTRY}/tmaxcloudck/template-operator:0.2.7

sudo docker load < cluster-tsb_0.1.4.tar
sudo docker tag tmaxcloudck/cluster-tsb:0.1.4 ${REGISTRY}/tmaxcloudck/cluster-tsb:0.1.4 
sudo docker push ${REGISTRY}/tmaxcloudck/cluster-tsb:0.1.4

sudo docker load < tsb_0.1.4.tar
sudo docker tag tmaxcloudck/tsb:0.1.4 ${REGISTRY}/tmaxcloudck/tsb:0.1.4
sudo docker push ${REGISTRY}/tmaxcloudck/tsb:0.1.4

popd
