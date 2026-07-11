{ config, pkgs, ... }: {
  imports = [
    ./hardware.nix
    ./system/boot.nix
    ./system/desktop.nix
    ./system/graphics.nix
    ./system/locale.nix
    ./system/maintenance.nix
    ./system/networking.nix
    ./system/packages.nix
    ./system/services.nix
    ./system/users.nix
  ];

  programs.dconf.enable = true;
  programs.fuse.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Let `sudo -e` (sudoedit) use the user's $EDITOR (itah's nvim), and allow
  # editing files inside user-writable dirs like /etc/nixos.
  security.sudo.extraConfig = ''
    Defaults env_keep += "EDITOR VISUAL"
    Defaults!/etc/nixos/ !sudoedit_checkdir
  '';

  system.stateVersion = "26.05";
}
