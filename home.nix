{ config, pkgs, lib, nixvim, nvf, ... }:

{
  home.username = "itah";
  home.homeDirectory = "/home/itah";
  home.stateVersion = "26.05";
  programs.home-manager.enable = true;

  imports = [
    ./home
    nixvim.homeModules.default
    nvf.homeManagerModules.nvf
  ];
}
