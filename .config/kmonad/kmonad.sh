#!/bin/bash

echo "kmonad.service: ## Starting ##" | systemd-cat -p info
/usr/local/bin/kmonad /home/zach/.config/kmonad/dasta-linux.kbd
