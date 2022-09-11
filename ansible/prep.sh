adduser zach sudo
apt install software-properties-common
apt-add-repository ppa:ansible/ansible
apt install ansible
ansible-galaxy collection install community.general