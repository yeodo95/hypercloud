echo -n "[hyperauth] Enter REGISTRY ip:port : "
read REGISTRY

export HYPERCLOUD_HOME=~/hypercloud-install
export HPCD_API_SERVER_VERSION=5.0.26.6
export HPCD_SINGLE_OPERATOR_VERSION=5.0.25.16
export HPCD_MULTI_OPERATOR_VERSION=5.0.25.14
export HPCD_MULTI_AGENT_VERSION=5.0.25.14
export HPCD_POSTGRES_VERSION=5.0.0.1

./img_load.sh

pushd ./manifest
sed -i'' "s/{REGISTRY}/"${REGISTRY}"/g" hypercloud.config

sudo chmod +x install.sh
./install.sh
popd