pushd release/

sudo hostnamectl set-hostname $HOSTNAME

echo $MASTER_IP $HOSTNAME >> /etc/hosts

sudo systemctl stop firewalld
sudo systemctl disable firewalld

sudo swapoff -a

sudo setenforce 0
sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

sudo modprobe overlay
sudo modprobe br_netfilter

sudo cat << "EOF" | sudo tee -a /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

sudo sysctl --system

sudo cat << "EOF" | sudo tee -a /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF
 
sudo sysctl --system

popd
