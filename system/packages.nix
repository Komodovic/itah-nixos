{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    adbfs-rootless
    adminneo
    adwaita-icon-theme
    adw-gtk3
    android-tools
    audacity
    bat
    bibata-cursors
    (brave.override { commandLineArgs = "--enable-features=VaapiVideoDecoder,VaapiVideoEncoder,AcceleratedVideoDecodeLinuxGL,AcceleratedVideoEncoder"; })
    brightnessctl
    btop
    cava
    cliphist
    eza
    fastfetch
    fd
    file
    fzf
    gcc
    git
    glib
    gnumake
    imv
    jmtpfs
    jq
    kdePackages.qt6ct
    kitty
    lazygit
    libreoffice-fresh
    localsend
    mariadb
    mpv
    mysql-workbench
    neovim
    netbeans
    nodejs
    obs-studio
    opencode
    playerctl
    ripgrep
    tldr
    trash-cli
    tree-sitter
    unar
    unzip
    wget
    xwayland-satellite
    yazi
    zathura
    zoxide
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
}
