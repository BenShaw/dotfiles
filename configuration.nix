# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  environment.pathsToLink = ["/libexec"]; 
  nixpkgs.config.allowUnfree = true;

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];


  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.useOSProber = true;

  networking = {
    
    hostName = "ben-nixos"; # Define your hostname.
    wireless.enable = false;  # Enables wireless support via wpa_supplicant.
    #networking.wireless.userControlled.enable = true;
    networkmanager.enable = true;
    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
    interfaces = {
      eno1.useDHCP = true;
      wlp4s0.useDHCP = true;
    };

    #firewall = {
    #        allowedTCPPorts = [ 1194 1205 ];
    #        allowedUDPPorts = [ 1194 1205 ];
    #      };
    firewall.enable = false;
  };

  programs.nm-applet.enable = true;


  #bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;


  virtualisation = {
    virtualbox.host.enable = true;
    docker.enable = true;
  };

  users.extraGroups.vboxusers.members = [ "ben" ];
 
  #fileSystems."/ssd".options = ["uid=1000" "gid=100" "dmask=007" "fmask=117"];

  # Set your time zone.
  time.timeZone = "America/Edmonton";

     # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Enable the X11 windowing system.
  #services.xserver.enable = true;
  # Enable the GNOME 3 Desktop Environment.
  #services.xserver.displayManager.gdm.enable = true;
  #services.xserver.desktopManager.gnome3.enable = true;
  

  services.xserver = {
    videoDrivers = ["amdgpu"];
    enable = true;   
    desktopManager = {
      #default = "xfce";
      xterm.enable = false;
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
      };
    };
    displayManager.defaultSession = "xfce+i3";

    windowManager.i3 = {
      package = pkgs.i3-gaps;
      enable = true;
      extraPackages = with pkgs; [
        dmenu #application launcher most people use
        i3status # gives you the default i3 status bar
        i3lock #default i3 screen locker
        i3blocks #if you are planning on using i3blocks over i3status
     ];
    };
  };

  # Configure keymap in X11
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "caps:swapescape";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;

  hardware = {
    pulseaudio = {
     enable = true;
     support32Bit = true;
     # NixOS allows either a lightweight build (default) or full build of PulseAudio to be installed.
     # Only the full build has Bluetooth support, so it must be selected here.
     package = pkgs.pulseaudioFull;
    };
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.ben = {
     isNormalUser = true;
     extraGroups = [ "sharedusers" "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
   };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # //todo seperate into user profile and system profile
  environment.systemPackages = with pkgs; [
     wget
     vimHugeX
     neovim
     firefox
     git
     clipit #clipboard history
     nitrogen #backgroun manager
     pcmanfm #file browser
     jetbrains.idea-community
     blueman
     pulseaudio
     albert
     picom
     zsh #/todo
     oh-my-zsh #/todo
     rustup
     gparted
     awscli2
     docker
     python
     slack
     curl
     unzip
     networkmanager_openvpn
     volumeicon
     pkg-config
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

  # flatpak
  # services.flatpak.enable = true;
  # xdg.portal.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

  #services.openvpn.servers = {
  #  scribd  = { 
  #    autoStart = true;
  #    updateResolvConf = true;
  #    
  # config = '' 
  #    client
  #    dev tun
  #    proto udp
  #    remote ca-east.gw.openvpn.cloud 1194 udp
  #    remote ca-east.gw.openvpn.cloud 1194 udp
  #    remote ca-east.gw.openvpn.cloud 443 tcp
  #    remote ca-east.gw.openvpn.cloud 1194 udp
  #    remote ca-east.gw.openvpn.cloud 1194 udp
  #    remote ca-east.gw.openvpn.cloud 1194 udp
  #    remote ca-east.gw.openvpn.cloud 1194 udp
  #    remote ca-east.gw.openvpn.cloud 1194 udp
  #    remote-cert-tls server
  #
  #    nobind
  #
  #    ca /home/ben/vpn/ca.crt
  #    cert /home/ben/vpn/client.crt
  #    key /home/ben/vpn/client.key
  #    tls-auth /home/ben/vpn/ta.key 1
  #
  #    cipher AES-256-CBC
  #    auth SHA256
  #    persist-tun
  #    socket-flags TCP_NODELAY
  #    verb 6
  #
  #  ''; };
  #};
}

