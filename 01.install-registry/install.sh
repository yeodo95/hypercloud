echo -n "[registry] Enter registry ip:port : "
read REGISTRY

sudo yum install -y docker-ce
sudo systemctl start docker
sudo systemctl enable docker

#echo -e "docker damon에 insecure-registries 등록 (sudo vi /etc/docker/daemon.json) \n{\n    "insecure-registries": ["{IP}:5000"]\n}"


if /etc/docker/daemon.json
then
  sudo sed -i'' "s/"insecure-registries".*/"insecure-registries": $REGISTRY/g" /etc/docker/daemon.json
else
  sudo touch /etc/docker/daemon.json
  chmod +x /etc/docker/daemon.json
  echo -e "{\n\"insecure-registries\": [\"$REGISTRY\"]\n}" >> /etc/docker/daemon.json
fi


sudo systemctl restart docker
sudo systemctl status docker

pushd ./release/resource
chmod +x run-registry.sh
sudo ./run-registry.sh \$PWD/resource/ $REGISTRY
popd

curl $REGISTRY/v2/_catalog