{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Hardware
  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    extraPackages = with pkgs; [ 
      rocmPackages.clr.icd
    ];
  };

  hardware.xpadneo.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Filesystems
  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/e5e64a7e-ad1e-4400-8433-98913936df9a";
      fsType = "btrfs";
      options = [ "subvol=@home" "compress=zstd" ];
    };

  # Networking
  networking.hostName = "R5"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Vancouver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dom = {
    isNormalUser = true;
    description = "Dom";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enabled Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Env
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  # Fonts
  fonts.packages = with pkgs; [
    font-awesome
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.droid-sans-mono
  ];

  # Packages
  environment.systemPackages = with pkgs; [
    # Hyprland
    kitty
    hyprpolkitagent
    dunst
    rofi
    waybar
    wl-clipboard
    cliphist
    hyprshot
    playerctl
    hyprpaper
    
    # Important
    neovim
    git
    stow
    vscode-fhs

    # XDG
    xdg-desktop-portal
    xdg-desktop-portal-hyprland
  ];

  # Programs
  programs.hyprland.enable = true;

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  # Services
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.gvfs.enable = true;
  services.flatpak.enable = true;

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  services.blueman.enable = true;

  services.snapper = {
    configs."home" = {
      SUBVOLUME = "/home";
      FSTYPE = "btrfs";
      
      # Optional: Allow the user 'dom' to use snapper without sudo/root
      ALLOW_USERS = [ "dom" ]; 
      
      # Optional: Enable automatic hourly snapshots and cleanup
      TIMELINE_CREATE = true;
      TIMELINE_CLEANUP = true;
      
      # Optional: Adjust the number of snapshots to keep
      TIMELINE_LIMIT_HOURLY = 5;
      TIMELINE_LIMIT_DAILY = 7;
      TIMELINE_LIMIT_MONTHLY = 0;
    };
  };

  # Udev
  services.udev.extraRules = ''
    # WLmouse Mini Receiver (ID 36a7:a885) - Grant read/write access for Web Panel
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="36a7", ATTRS{idProduct}=="a885", MODE="0666", TAG+="uaccess"
  '';

  # Firewall
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 25565 ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
