# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> {};
in

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
#      ./wm.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # enable automatic garbage collection
  nix.gc.automatic = true;
  nix.gc.dates = "18:00";

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";
  networking.networkmanager.enable = true;
  networking.hostName = "mobile"; # Define your hostname.

  # Set Networking Configs
  networking.useDHCP = false;
  networking.interfaces.enp0s21f0u5.useDHCP = true;
  networking.interfaces.wlp2s0.useDHCP = true;

  # Set locale
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.windowManager.i3.enable = true;
  services.xserver.windowManager.xmonad.enable = true;
  services.xserver.windowManager.xmonad.enableContribAndExtras = true;
  services.xserver.windowManager.xmonad.extraPackages = haskellPackages: [
    unstable.haskellPackages.xmobar
    unstable.haskellPackages.xmonad
    unstable.haskellPackages.xmonad-contrib
    unstable.haskellPackages.xmonad-extras
  ];

  # Enable rdp
  services.xrdp.enable = true;
  services.xrdp.defaultWindowManager = "xmonad";

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # needed for store VSCode auth token
  services.gnome.gnome-keyring.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.zach = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
   };

  # add wheel users to sudoers
  security.sudo.wheelNeedsPassword = false;


  # install packages
  environment.systemPackages = with pkgs; [
    # x tools
    alacritty
    google-chrome
    networkmanager
    # Command line tools
    mosh
    fish
    git
    wget
    neovim
    tmux
    unstable.helix
    # xmonad stuff
    nitrogen
    picom
    rofi
    vscode
  ];

  nixpkgs.config.allowUnfree = true;

  # Set newvim as default editor
  environment.variables.EDITOR = "nvim";

  # add aliases for neovim
  nixpkgs.overlays = [
    (self: super: {
      neovim = super.neovim.override {
        viAlias = true;
        vimAlias = true;
      };
     })
 ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 3389 ];
  networking.firewall.allowedUDPPortRanges = [ { from = 60000; to = 61000; } ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

}
