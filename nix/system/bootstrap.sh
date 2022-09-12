# install home-manager
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
nix-channel --update

set -x NIX_PATH /home/zach/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels:nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos:nixos-config=/etc/nixos/configuration.nix:/nix/var/nix/profiles/per-user/root/channels

nix-shell '<home-manager>' -A install

# pull bits from github
alias config '/home/zach/.nix-profile/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
echo ".cfg" >> .gitignore
git clone --bare https://github.com/zachthieme/nixos.git $HOME/.cfg
config checkout --force

# install all apps/config
home-manager switch -b backup

# install binary cache database
nix-index
