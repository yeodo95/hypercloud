pushd release/

sudo yum -y install cri-o
sudo systemctl enable crio
sudo systemctl start crio

sudo rm -rf  /etc/cni/net.d/100-crio-bridge.conf
sudo rm -rf  /etc/cni/net.d/200-loopback.conf
sudo rm -rf /etc/cni/net.d/87-podman-bridge.conflist

echo -n "[k8s] is it private network? [y/n] : "
read NETWORK_CHECK

if [[ "$NETWORK_CHECK" == "y" ]];
then
  export NETWORK_TYPE="private"
else
  export NETWORK_TYPE="public"
fi

if [[ "$NETWORK_TYPE" == "private" ]];
then
  sudo sed -i'' "s/#insecure_registries.*/insecure_registries = [\"$REGISTRY\"]/g" /etc/crio/crio.conf
  sudo sed -i'' "s/#registries.*/registries = [\n\"$REGISTRY\"\n]/g" /etc/crio/crio.conf
  sudo sed -i'' "s/pids_limit.*/pids_limit = 32768/g" /etc/crio/crio.conf
  sudo sed -i'' "s/unqualified-search-registries = \[/unqualified-search-registries = \[\"$REGISTRY\", /g" /etc/containers/registries.conf
fi

sudo systemctl restart crio

popd