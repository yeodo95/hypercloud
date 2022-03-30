echo -n "[grafana] Enter REGISTRY ip:port : "
read REGISTRY
echo -n "[grafana] Enter hyperauth address : "
read HYPERAUTH_ADDRESS
echo -n "[grafana] Enter grafana client secret : "
read CLIENT_SECRET
echo -n "[grafana] Enter console address : "
read CONSOLE_ADDRESS


export CLIENT_ID=grafana
export REGISTRY
export HYPERAUTH_ADDR
export CLIENT_SECRET
export CONSOLE_ADDRESS

pushd ./manifest
sed -i'' "s/{REGISTRY}/"${REGISTRY}"/g" version.conf
sed -i'' "s/{HYPERAUTH_ADDRESS}/"${HYPERAUTH_ADDRESS}"/g" version.conf
sed -i'' "s/{CLIENT_SECRET}/"${CLIENT_SECRET}"/g" version.conf
sed -i'' "s/{CONSOLE_ADDRESS}/"${CONSOLE_ADDRESS}"/g" version.conf
sed -i'' "s/{CLIENT_ID}/"${CLIENT_ID}"/g" version.conf

sudo chmod +x install.sh
./install.sh
popd