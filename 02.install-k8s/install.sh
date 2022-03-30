git clone -b 5.0 --single-branch https://github.com/yeodo95/hypercloud.git
mv hypercloud/02.install-k8s/* ./
rm -rf hypercloud/

echo -n "[k8s] Enter hostname : "
read HOSTNAME
echo -n "[k8s] Enter registry ip:port : "
read REGISTRY
echo -n "[k8s] Enter API server IP (master IP) : "
read MASTER_IP
echo -n "[k8s] Enter serviceSubnet (10.96.0.0/16) : "
read SERVICE_SUBNET
echo -n "[k8s] Enter podSubnet(10.244.0.0/16) : "
read POD_SUBNET

export HOSTNAME
export REGISTRY
export MASTER_IP
export SERVICE_SUBNET
export POD_SUBNET
chmod +x step_0.sh step_1.sh step_2.sh step_3.sh
./step_0.sh 
./step_1.sh 
./step_2.sh 
./step_3.sh