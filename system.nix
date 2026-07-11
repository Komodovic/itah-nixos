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

  # Allow `itah` to run nix/nixos-rebuild via sudo without a password prompt.
  security.sudo.extraRules = [{
    users = [ "itah" ];
    commands = [
      { command = "/run/current-system/sw/bin/nixos-rebuild"; options = [ "NOPASSWD" ]; }
      { command = "/run/wrappers/bin/nixos-rebuild"; options = [ "NOPASSWD" ]; }
      { command = "/run/current-system/sw/bin/nix"; options = [ "NOPASSWD" ]; }
    ];
  }];

  system.stateVersion = "26.05";
}
