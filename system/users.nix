{ config, pkgs, lib, ... }: {
  services.getty.autologinUser = lib.mkForce "itah";

  users.users."itah" = {
    isNormalUser = true;
    description = "itah";
    extraGroups = [ "networkmanager" "wheel" "adbusers" ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;
}
