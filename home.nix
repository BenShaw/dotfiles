{ config, pkgs, ... }:

with pkgs;
let
  my-python2-packages = python27-packages: with python27-packages; [
    pip
    setuptools
    virtualenv
    #requests
    # other python packages you want
  ]; 
  python2-with-my-packages = python2.withPackages my-python2-packages;
in

{

  
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "ben";
  home.homeDirectory = "/home/ben";

  home.sessionVariables = {
  	AWS_PROFILE = "coreplat_dev_admin";
  };


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
    python2-with-my-packages
    docker-compose
    nextcloud-client
    transmission-gtk
    texmaker
    libstdcxx5
    ruby.devEnv
    sqlite
    libpcap
    postgresql
    libxml2
    libxslt
    pkg-config
    bundix
    gnumake
    google-chrome
    nerdfonts
    ctags
    htop
    fortune
    #neovim
    firefox
    git
    jetbrains.idea-community
    rustup
    awscli2
    docker
    slack
    alacritty
    okular
    p7zip
    #pkg-config-wrapper
    #python37
    #pkgs.python3.7
    silver-searcher
    spotify
    terraform_0_13
    terragrunt
    tree
    #vimplugin-vimwiki
    zoom
    parted
    gcc
    binutils
    kdiff3
    go
    gimp-with-plugins
    mypy
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
    ];
  };


   programs.neovim = {
    enable = true;
    configure = {
    	customRC = ''let g:vimwiki_list = [{'path': '~/nextcloud/notes/',
                       \ 'syntax': 'markdown', 'auto_toc' : 1,
                       \ 'ext': '.md'}]'';
	packages.myPlugins = with pkgs.vimPlugins; {
	 start = [ sensible
      		vim-airline
      		The_NERD_tree # file system explorer
      		fugitive vim-gitgutter # git 
      		rust-vim
      		#YouCompleteMe
      		command-t
      		vim-go
      		vim-terraform
      		vimwiki
      		semshi];
	opt = [];
	};

    };

    extraPythonPackages = (ps: with ps; [ ]);
    extraPython3Packages = (ps: with ps; [ ]);
   };

  programs.zsh = {
    enable = true;

    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
    };

    initExtra =  "[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh";
    #shellInit = "[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh";
    
    history = {
      size = 10000;
    };


    zplug = {
      enable = true;
      plugins = [
       { name = "zsh-users/zsh-autosuggestions"; } # Simple plugin installation
        { name = "rupa/z"; } # Simple plugin installation

       { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; } 
        { name = "mafredri/zsh-async"; tags = [ from:github ];}
	{ name = "sindresorhus/pure"; tags =[use:pure.zsh from:github as:theme ]; }             
        { name = "relastle/eucalyptus"; tags =[use:pure.zsh from:github as:theme ]; }             
	
      ];
    };

   

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
