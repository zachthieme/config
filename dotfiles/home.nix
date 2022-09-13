{ config, pkgs, ... }:
 let
   unstable = import <nixos-unstable> {};
 in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "zach";
    homeDirectory = "/home/zach";

    # source config files
    file."/home/zach/.config/starship.toml".source = ./starship/starship.toml;
    file."/home/zach/.tmux.conf".source = ./tmux/tmux.conf;
    file."/home/zach/.config/gitui/key_bindings.ron".source = ./gitui/key_bindings.ron;
    file."/home/zach/.config/helix/config.toml".source = ./helix/config.toml;
    file."/home/zach/.config/kitty/kitty.conf".source = ./kitty/kitty.conf;
  };

  # enable unFree programs (code, chrome) to be installed
  nixpkgs.config.allowUnfree = true;

  home.packages = [

    # faster newer better terminal tools
    unstable.gitui         # lazy way to manage git
    unstable.rargs         # similar to xargs
    unstable.tealdeer      # rust version of tldr that shows simple man
    unstable.zenith        # top like tools with graphs 
    unstable.comma         # app that will pull files from the nix store but not install them
  ];

  programs = {
    home-manager.enable = true;

    # setup my git configurations
    gh.enable = true;
    git = {
      enable= true;
      userName = "zachthieme";
      userEmail = "zach@techsage.org";
      aliases = {
        st = "status";
      };
    };

    neovim = {
      package = unstable.neovim-unwrapped;
      enable = true;
      viAlias = true;
      vimAlias = true;
      plugins = with unstable.vimPlugins;
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
          vim-lsp
          nvim-lspconfig
          telescope-nvim 
        ];
        extraConfig = builtins.readFile ./nvim/init.vim;
    };

  };	

  home.stateVersion = "22.05";

}
