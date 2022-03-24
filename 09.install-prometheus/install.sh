pushd ./manifest
source version.conf
chmod +x version.conf
chmod +x setLocalReg.sh
./setLocalReg.sh

mv /user/bin yq

chmod +x ./install.sh
./install.sh
popd