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
      mpv
    ];

    productivity = [
      # Productivity
      btop  # replacement of htop/nmon
    ];
  in
    flake_apps
    ++ apps
    ++ utils
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