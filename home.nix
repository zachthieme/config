{ config, pkgs, ... }:
let
  unstable = import <nixos-unstable> {};
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "zach";
  home.homeDirectory = "/home/zach";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  
  nixpkgs.config.allowUnfree = true;

  home.packages = [
    # x tools
    pkgs.alacritty
    pkgs.vscode
    pkgs.google-chrome
    # Command line tools
    pkgs.mosh
    pkgs.fish
    pkgs.git 
    pkgs.wget
    pkgs.neovim
    pkgs.tmux
    unstable.helix
    unstable.starship
    # xmonad stuff
    pkgs.nitrogen
    pkgs.picom
    pkgs.rofi
  ];
  xsession.windowManager.xmonad.enable = true;  
  xsession.windowManager.xmonad.enableContribAndExtras = true;
  xsession.windowManager.xmonad.extraPackages = haskellPackages: [
    unstable.haskellPackages.xmobar
    unstable.haskellPackages.xmonad  
    unstable.haskellPackages.xmonad-contrib
    unstable.haskellPackages.xmonad-extras  
  ];

  xsession.windowManager.xmonad.config = /home/zach/.config/xmonad/xmonad.hs;
}
