mkdir /home/zach/Code
cd /home/zach/Code
git clone https://github.com/zachthieme/config.git

# install nixos
sh <(curl -L https://nixos.org/nix/install) --daemon
#
# install home manager 
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
nix-channel --update
export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
nix-shell '<home-manager>' -A install

# link config files to proper place
ln -s /home/zach/Code/config/dotfiles/* /home/zach/.config/

# bring configuration live
home-manager switch
