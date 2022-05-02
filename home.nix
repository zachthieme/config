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
zach@mobile ~> cat .config/nixpkgs/home.nix 
{ config, pkgs, ... }:
let
  unstable = import <nixos-unstable> {};
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "zach";
  home.homeDirectory = "/home/zach";

  # setup my git configurations
  programs = {
    home-manager.enable = true;

	 git = {
      enable= true;
      userName = "zachthieme";
      userEmail = "zach@techsage.org";
      aliases = {
        st = "status";
      };
    };
		
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      plugins = with pkgs.vimPlugins;
	 	  [  
        vim-airline 
	     	(nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars ))
        vim-surround
        auto-pairs
	      vim-numbertoggle
	      vim-which-key
	      vim-smoothie
	      nerdtree
	      vim-easymotion
				vim-nix
      ];
# TODO: use this to read the init.vim file
# extraConfig = builtins.readFile ./init.vim`
      extraConfig = ''
        inoremap jj <Esc>
        nnoremap JJJJ <Nop> 

       " get the relative number and regular number set for different context
       set number relativenumber
       set nowrap
       
	 	" Editor Config
       " Set the leader key to space
       nnoremap <SPACE> <Nop>
       let mapleader=" "
       
       " default nerdtree to showing hidded files
       let NERDTreeShowHidden=1

	 	" set which key command
	 	nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

	 	" toggle word wrap
       map <leader>w :set wrap!<CR>

       " set the tab width - both numbers need to be the same
       set shiftwidth=2
       set tabstop=2
       set autoindent

       " remove highlighting from searches
       set nohlsearch
       set nowrap
       set scrolloff=8
       set incsearch
       set modeline

       map <leader>f :Files<CR>
       map <leader>b :Buffers<CR>
	 	
       " Copy to system clipboard
       map <leader>c "*y

       " Paste from system clipboard
       map <leader>p "*[p

       " clear out search
       map <leader>h :let @/ = ""<CR>

       " flatten list into comma seperated
       map <leader>l :%s/\n/,/g<CR>

       " nerdtree shortcut
	 	map <leader>n :NERDTreeToggle<CR>
      '';
    };
	};	
  
  home.stateVersion = "21.11";


  # enable unFree programs (code, chrome) to be installed
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
    unstable.ansible
    pkgs.wget
#    pkgs.neovim
    pkgs.tmux
    unstable.helix
    unstable.starship
    unstable.gh
    # xmonad stuff
    unstable.rofi
  ];

  xsession = {
		enable = true;

	 windowManager = {
		 xmonad = {
			 enable = true;  
        enableContribAndExtras = true;
        extraPackages = haskellPackages: [
#          unstable.haskellPackages.xmobar
          unstable.haskellPackages.xmonad  
          unstable.haskellPackages.xmonad-contrib
          unstable.haskellPackages.xmonad-extras  
        ];
        config = /home/zach/.config/xmonad/xmonad.hs;
			};
    }; 			
  };
}
