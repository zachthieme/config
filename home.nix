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
