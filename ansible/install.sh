adduser zach sudo
sed -i "s/\%sudo    ALL=(ALL:ALL) ALL/\%sudo ALL=(ALL:ALL) NOPASSWD:ALL/" /etc/sudoers
apt install software-properties-common
apt-add-repository ppa:ansible/ansible
apt update
apt install ansible
ansible-galaxy collection install community.general
