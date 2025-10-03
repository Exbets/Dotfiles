{ config, pkgs, inputs, ... }:

{
  home.username = "dom";
  home.homeDirectory = "/home/dom";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

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
  home.packages = with pkgs; [
    # Flake Apps
    inputs.viu.packages.${pkgs.system}.default

    # Apps
    gnome-text-editor
    gnome-calculator
    gnome-disk-utility
    nautilus

    brave
    spotify
    pavucontrol
    mpv
    qdiskinfo
    gimp3
    btrfs-assistant
    postman
    prismlauncher
    qbittorrent

    # Utils
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder
    fastfetch # Better Neofetch
    cava # CLI audio visuals
    peaclock # CLI clock
    imv # Image viewer
    oh-my-posh
    pywal
    cmus # CLI music player
    distrobox # Wrapper around podman or docker to create and start containers
    distroshelf # GUI for Distrobox Containers

    # Nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    # Productivity
    hugo # static site generator
    glow # markdown previewer in terminal

    python314 # Python

    btop  # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb
  ];

  # Programs

  # git
  programs.git = {
    enable = true;
    userName = "exbets";
    userEmail = "domgorkoff@gmail.com";
  };

  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.11";
}
