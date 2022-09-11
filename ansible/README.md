# How To Run Ansible Stuff

## this command should bring all hosts up to current setting 

    ➜ ansible-playbook configurations.yml -i inventory.yaml --ask-vault-pass --extra-vars @secrets.enc 

## retry with limited hosts 

    ➜ ansible-playbook configurations.yml -i inventory.yaml --ask-vault-pass --extra-vars @secrets.enc --limit @/home/zach/.config/ansible/test.yml

## run with a particular host group
    ➜ ansible-playbook configurations.yml -i inventory.yaml --ask-vault-pass --extra-vars @secrets.enc -l desktop

## execute the below commands

<https://gist.githubusercontent.com/zachthieme/3bc2fa206e2922543232725a68c3bcb2/raw/f7ce7f37f78a56ca776713844e0d414a3fb8bf5d/Commands.sh>

## Encrypt a file

    ➜  ansible-vault encrypt secrets.enc

## install unifi controller
https://community.ui.com/questions/UniFi-Installation-Scripts-or-UniFi-Easy-Update-Script-or-UniFi-Lets-Encrypt-or-UniFi-Easy-Encrypt-/ccbc7530-dd61-40a7-82ec-22b17f027776

## adhoc command
    ➜ ansible k8 -m command -a uptime -i inventory.yaml
	
# For PopOS hosts
```sudo adduser zach sudo
sudo apt install software-properties-common
sudo apt-add-repository ppa:ansible/ansible
sudo apt install ansible
ansible-galaxy collection install community.general```
logout / login 


