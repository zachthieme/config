# How To Run Ansible Stuff

## this command should bring all hosts up to current setting 

    ➜ ansible-playbook configurations.yml -i inventory.yaml --ask-vault-pass --extra-vars @secrets.enc 

## retry with limited hosts 

    ➜ ansible-playbook configurations.yml -i inventory.yaml --ask-vault-pass --extra-vars @secrets.enc --limit @/home/zach/.config/ansible/test.yml

## execute the below commands

<https://gist.githubusercontent.com/zachthieme/3bc2fa206e2922543232725a68c3bcb2/raw/f7ce7f37f78a56ca776713844e0d414a3fb8bf5d/Commands.sh>

## Encrypt a file

    ➜  ansible-vault encrypt secrets.enc

## adhoc command
    ➜ ansible k8 -m command -a uptime -i inventory.yaml
	
