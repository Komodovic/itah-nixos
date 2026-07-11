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

    # --- polished CLI delights (added) ---
    atuin        # fuzzy, searchable shell history
    bat-extras.batdiff  # git diff via bat
    bat-extras.batman   # man pages via bat
    delta        # pretty git diffs (pairs with gh)
    dust         # pretty disk-usage tree
    nh           # NixOS rebuild helper
    ouch         # extract ANY archive with one command
    pay-respects # suggest fixes for failed commands (thefuck successor)
    procs        # colorful process list
    starship     # informative, pretty shell prompt
    tokei        # count lines of code per language
    watchexec    # rerun a command on file change
    yq           # jq for YAML/TOML
    gh           # GitHub CLI
  ];

  # --- git: use delta for pretty diffs ---
  programs.git = {
    enable = true;
    config = {
      core.pager = "delta";
      interactive.diffFilter = "delta --color-only";
      delta = {
        navigate = true;
        "side-by-side" = true;
        hyperlinks = true;
        "file-style" = "omit";
        "hunk-header-style" = "omit";
      };
    };
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
}
