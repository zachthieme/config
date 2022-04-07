# TODO: add ansible for service https://www.howtogeek.com/687970/how-to-run-a-linux-program-at-startup-with-systemd/
#!/bin/bash

echo "kmonad.service: ## Starting ##" | systemd-cat -p info

while :
do
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
echo "kmonad.service: timestamp ${TIMESTAMP}" | systemd-cat -p info
sleep 60
done
