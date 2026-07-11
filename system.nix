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

  system.stateVersion = "26.05";
}
