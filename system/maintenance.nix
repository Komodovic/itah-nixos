{ ... }: {
  boot.loader.systemd-boot.configurationLimit = 5;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  nix.optimise.automatic = true;
  nix.optimise.dates = [ "weekly" ];

  system.autoUpgrade = {
    enable = true;
    flake = "/etc/nixos#nixos";
    flags = [ "--update-input" "nixpkgs" "-L" ];
    dates = "weekly";
    allowReboot = false;
  };
}
