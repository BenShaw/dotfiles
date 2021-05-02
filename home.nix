{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "ben";
  home.homeDirectory = "/home/ben";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.03";
  home.packages = with pkgs; [
    htop
    fortune
     neovim
     firefox
     git
     jetbrains.idea-community
         zsh #/todo
     oh-my-zsh #/todo
     rustup
     awscli2
     docker
     python
     slack
    alacritty
    okular
    p7zip
    #pkg-config-wrapper
    python3
    #pkgs.python3.7
    silver-searcher
    spotify
    terraform
    tree
    #vimplugin-vimwiki
    zoom
  ];

    programs.git = {
      enable = true;
      userName  = "Ben Shaw";
      userEmail = "shawty.13@gmail.com";
    };

  programs.vim = {
    enable = true;
    
    plugins = with pkgs.vimPlugins; [
      sensible
      vim-airline
      The_NERD_tree # file system explorer
      fugitive vim-gitgutter # git 
      rust-vim
      #YouCompleteMe
      command-t
      vim-go
      vim-terraform
      python-mode
    ];
  };

  home.file = {
  ".xprofile" = {
    text = ''
      eval $(/run/wrappers/bin/gnome-keyring-daemon --start --daemonize)
      export SSH_AUTH_SOCK
    '';
  };
  };
}
