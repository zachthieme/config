# How To Run Ansible Stuff

## execute the below command and it should execute all the playbooks in order

    ➜  ansible-playbook newPi.yml -i inventory.yaml --ask-vault-pass --extra-vars @secrets.enc

## execute the below commands

<https://gist.githubusercontent.com/zachthieme/3bc2fa206e2922543232725a68c3bcb2/raw/f7ce7f37f78a56ca776713844e0d414a3fb8bf5d/Commands.sh>

## Encrypt a file

    ➜  ansible-vault encrypt secrets.enc