{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # make sure the config is stored in case you accidentally over write
  system.copySystemConfiguration = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # enable automatic garbage collection
  nix.gc.automatic = true;
  nix.gc.dates = "18:00";

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";
  
  networking.networkmanager.enable = true;
  networking = {
    hostName = "mobile"; # Define your hostname.

    # Set Networking Configs
    useDHCP = false;
    interfaces = {
      enp0s21f0u5.useDHCP = true;
      wlp2s0.useDHCP = true;
    };

    # Open ports in the firewall.
    firewall = {
      allowedTCPPorts = [ 3389 ];
      allowedUDPPortRanges = [ { from = 60000; to = 61000; } ];
    };
  };

  # Set locale
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # set shells
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  # Enable the X11 windowing system.
  services = {
    xserver = {
      enable = true;
      displayManager.lightdm.enable = true;
      windowManager.i3.enable = true;
      windowManager.xmonad.enable = true;
    };

    # needed for store VSCode auth token
    gnome.gnome-keyring.enable = true;

    # Enable rdp
    xrdp = {
      enable = true;
      defaultWindowManager = "xmonad";
    };

    # Enable CUPS to print documents.
    printing.enable = true;

    # Enable the OpenSSH daemon.
    openssh.enable = true;
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.zach = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
   };

  # add wheel users to sudoers
  security.sudo.wheelNeedsPassword = false;

  # install packages
  environment.systemPackages = with pkgs; [
    wget
    tmux
    (
      with import <nixpkgs> {};

      vim_configurable.customize {
        name = "vim";
        vimrcConfig.customRC = ''
          inoremap jj <Esc>
          nnoremap JJJJ <Nop> 
          set number relativenumber
          set nowrap
        '';
        vimrcConfig.plug.plugins = with pkgs.vimPlugins; [vim-nix];
      }
     )
  ];

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "21.11"; # Did you read the comment?

}
