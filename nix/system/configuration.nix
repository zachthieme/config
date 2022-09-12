{ config, pkgs, ... }:
 let
   unstable = import <nixos-unstable> {};
 in

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # copy nixos config file to /run/current-system/configuration.nix 
  system.copySystemConfiguration = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # enable automatic garbage collection
  nix.gc.automatic = true;
  nix.gc.dates = "18:00";
  nix.autoOptimiseStore = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";
  
  networking.networkmanager.enable = true;

#  networking.networkmanager.unmanaged = [ "rndis0" "usb0" ];        # figure out if this is something to do with usb

  networking = {
    hostName = "mobile"; # Define your hostname.

    # Set Networking Configs
    useDHCP = false;
    interfaces = {
      enp0s21f0u5.useDHCP = true;
      wlp2s0.useDHCP = true;
#      usb0.ipv4.addresses = [ {
#        address = "10.30.0.30";
#        prefixLength = 24;
#      } ];
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

  # Enable Docker
  virtualisation.docker.enable = true;

  # Enable the X11 windowing system.
  services = {
    dnsmasq = {
      enable = true;
      extraConfig = ''
        interface=usb0
        dhcp-range=10.30.0.2,10.30.0.6,255.255.255.248,1h
        dhcp-option=3
        leasefile-ro
      '';
    };

    xserver = {
      enable = true;
      libinput = {
        enable = true;
        mouse.naturalScrolling = true;
      };
      displayManager.lightdm.enable = true;
      windowManager.i3.enable = true;
      windowManager.xmonad.enable = true;
    };

    dbus = {
      enable = true;
      packages = [ pkgs.gnome3.dconf ];
    };

    # needed for store VSCode auth token
    gnome.gnome-keyring.enable = true;

    # Enable rdp
    xrdp = {
      enable = true;
      defaultWindowManager = "awesome";
    };

    # Enable CUPS to print documents.
    printing.enable = true;

    # Enable the OpenSSH daemon.
    openssh.enable = true;

  };

  systemd.services.dnsmasq.preStart = ''
    mkdir -p /var/lib/dnsmasq
    chmod 0700 /var/lib/dnsmasq
    chown dnsmasq /var/lib/dnsmasq
  '';

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.zach = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ]; # Enable ‘sudo’ for the user.
   };

  # add wheel users to sudoers
  security.sudo.wheelNeedsPassword = false;

  # install packages
  environment.systemPackages = with pkgs; [
    wget
    alacritty
    firefox
#    linuxKernel.packages.linux_5_10.usbip              # used to share usb devices across the network  
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

     # needed to install comma which allows us to run commands that aren't on our machine
     unstable.comma         
     unstable.nix-index     # builds indext so comma can find commands
  ];

  nixpkgs.config.allowUnfree = true;

  #nixpkgs.overlays = [
  #  (pself: psuper: {
  #    msd = pself.extend (self: super: {
  #    extra_utils = [ ];
  #    initrd_script = ''
  #    modprobe -v usb_f_acm
  #    modprobe -v usb_f_mass_storage
  #    modprobe -v usb_f_rndis
  #    cd /sys/kernel/config/usb_gadget
  #    mkdir g1
  #    cd g1
  #    mkdir functions/acm.GS0
  #    mkdir functions/mass_storage.GS0
  #    echo 1 > functions/mass_storage.GS0/lun.0/removable
  #    if [ -e /dev/mmcblk0 ]; then
  #    echo /dev/mmcblk0 > functions/mass_storage.GS0/lun.0/file
  #    else
  #    echo /disk.img > functions/mass_storage.GS0/lun.0/file
  #    fi
  #    mkdir functions/rndis.GS0
  #    mkdir configs/c.1
  #    mkdir configs/c.1/strings/0x409
  #    echo "Serial Console + MSD" > configs/c.1/strings/0x409/configuration
  #    mkdir strings/0x409
  #    echo "Zach Thieme" > strings/0x409/manufacturer
  #    echo "Mobile" > strings/0x409/product
  #    grep Serial /proc/cpuinfo  | cut -c19-26 > strings/0x409/serialnumber
  #    ln -sv functions/acm.GS0 configs/c.1
  #    #ln -sv functions/mass_storage.GS0 configs/c.1
  #    ln -sv functions/rndis.GS0 configs/c.1
  #    echo fe980000.usb > UDC
  #    cd /
  #    getty 0 /dev/ttyGS0 &
  #    sleep 5
  #  '';
  #  });
  #})];

  system.stateVersion = "21.11"; # Did you read the comment?

}

