# How To Run Ansible Stuff

## this command should bring all hosts up to current setting 

    ansible-playbook configurations.yml -i inventory.yaml --ask-vault-pass --extra-vars @secrets.enc 

## retry with limited hosts 

    ansible-playbook configurations.yml -i inventory.yaml --ask-vault-pass --extra-vars @secrets.enc --limit @/home/zach/.config/ansible/test.yml

## run with a particular host group
    ansible-playbook configurations.yml -i inventory.yaml --ask-vault-pass --extra-vars @secrets.enc -l desktop

## Encrypt a file

    ansible-vault encrypt secrets.enc

## adhoc command
    ansible k8 -m command -a 'uptime' -i inventory.yaml
	
# For PopOS hosts 
    sudo -i
    sh -c "$(wget https://raw.githubusercontent.com/zachthieme/config/master/ansible/install.sh -O -)"
    exit
    sh -c "$(wget https://raw.githubusercontent.com/zachthieme/config/master/ansible/user.sh -O -)"
