echo -n "[console] Enter REGISTRY ip:port : "
read REGISTRY
echo -n "[console] Enter hyperauth address : "
read HYPERAUTH_ADDRESS
echo -n "[console] Enter console address : "
read CONSOLE_ADDRESS

export HPCD_API_SERVER_VERSION=5.0.26.6
export HPCD_SINGLE_OPERATOR_VERSION=5.0.25.16
export HPCD_MULTI_OPERATOR_VERSION=5.0.25.14
export HPCD_MULTI_AGENT_VERSION=5.0.25.14
export HPCD_POSTGRES_VERSION=5.0.0.1

./img_load.sh

sed -i'' "s/docker.io/"${REGISTRY}"/g" Makefile.properties
sed -i'' "s/hyperauth.org/"${HYPERAUTH_ADDRESS}"/g" Makefile.properties
sed -i'' "s/console/"${CONSOLE_ADDRESS}"/g" Makefile.properties

sudo chmod +x install_nip_io.sh
./install_nip_io.sh