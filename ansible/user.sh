mkdir /home/zach/Code
cd /home/zach/Code
git clone https://github.com/zachthieme/config.git

# link config files to proper place
ln -s /home/zach/Code/config/dotfiles/* /home/zach/.config/
