{ config, pkgs, inputs, ... }:

{
  # Config
  home.username = "dom";
  home.homeDirectory = "/home/dom";

  # Links
  home.file.".config" = {
    source = ./config;
    recursive = true;
  };

  home.file.".bashrc" = {
    source = ./home/.bashrc;
  };

  # Themes
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
  };

  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  # Enable dconf settings for dark mode
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };

  # Packages
  home.packages = with pkgs; let
    flake_apps = [
      # Flake Apps
      inputs.viu.packages.${pkgs.stdenv.hostPlatform.system}.default # Viu
    ];

    apps = [
      # Apps
      gnome-text-editor # Gnome Text Editor
      gnome-calculator # Gnome Calculator
      gnome-disk-utility # Gnome Disks
      nautilus # Gnome File Manager

      brave # Web Browser
      pavucontrol # Volume Control
      mpv # Video Player
      imv # Image Viewer
      qdiskinfo # Basically Crystal Disk
      btrfs-assistant # GUI for btrfs
      postman # API Client
      distroshelf # GUI for Distrobox Containers
      gdu # Disk Usage Analyzer
      spotify # Spotify Music
      protonvpn-gui # VPN
      lutris # Game Launcher
      obs-studio # Screen Recording
      calibre # E Book Manager
    ];

    utils = [
      # Utils
      eza # A modern replacement for ‘ls’
      fzf # A command-line fuzzy finder
      fastfetch # Better Neofetch
      cava # CLI audio visuals
      peaclock # CLI clock
      oh-my-posh # Prompt Engine for Shell
      pywal # Generates Colour Themes
      cmus # CLI music player
      distrobox # Wrapper around podman or docker to create and start containers
    ];

    nix_tools = [
      # Nix related
      nix-output-monitor
    ];

    productivity = [
      # Productivity
      glow # markdown previewer in terminal
      
      btop  # replacement of htop/nmon
      iotop # io monitoring
      iftop # network monitoring

      # system call monitoring
      strace # system call monitoring
      lsof # list open files

      # system tools
      sysstat
      lm_sensors # for `sensors` command
      ethtool
      pciutils # lspci
      usbutils # lsusb
    ];
  in
    flake_apps
    ++ apps
    ++ utils
    ++ nix_tools
    ++ productivity;

  # Programs

  # HyprPanel
  programs.hyprpanel = {
    enable = true;
    package = inputs.hyprpanel.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };

  # Refer to flake for real version.
  home.stateVersion = "25.11";
}