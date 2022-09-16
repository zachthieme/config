adduser zach sudo
sed -i "s/\%sudo\s*ALL=(ALL:ALL) ALL/\%sudo ALL=(ALL:ALL) NOPASSWD:ALL/" /etc/sudoers
apt -y install software-properties-common
apt-add-repository ppa:ansible/ansible -y
apt -y update
apt -y install ansible
ansible-galaxy collection install community.general
ansible-galaxy collection install ansible.posix
