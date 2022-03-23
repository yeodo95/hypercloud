source release/version.conf
chmod +x release/version.conf
chmod +x release/setLocalReg.sh
./release/setLocalReg.sh

mv /user/bin yq

chmod +x ./release/install.sh
./release/install.sh