{ ... }: {
  flake.modules.nixos.base = { inputs, ... }: {
    system.stateVersion = "26.05";
    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    home-manager.sharedModules = [ inputs.nvf.homeManagerModules.nvf ];
  };
}
