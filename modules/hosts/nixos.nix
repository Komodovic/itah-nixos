{ inputs, config, ... }: let
  homeModules = builtins.attrValues config.flake.modules.homeManager;
in {
  flake.nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    modules = [
      inputs.home-manager.nixosModules.default
      {
        home-manager.users.itah = {
          imports = homeModules;
        };
      }
    ] ++ builtins.attrValues config.flake.modules.nixos;
  };
}
