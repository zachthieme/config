mkdir /home/zach/Code
cd /home/zach/Code
git clone https://github.com/zachthieme/config.git

# link config files to proper place
ln -s /home/zach/Code/config/dotfiles/* /home/zach/.config/
sed -i "s/Icon=kitty\Icon=/home/zach/.config/kitty/whiskers.png" /usr/share/applications/kitty.desktop:
