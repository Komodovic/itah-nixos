{ inputs, config, ... }: let
  homeModules = builtins.attrValues config.flake.modules.homeManager;
in {
  flake.nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      inputs.home-manager.nixosModules.default
      {
        home-manager = {
          backupFileExtension = "hm-backup";
          users.itah = {
            imports = homeModules;
          };
        };
      }
      config.flake.modules.nixos.nixos
    ];
  };

  flake.modules.nixos.nixos = {
    imports = with config.flake.modules.nixos; [
      base
      boot
      desktop
      fonts
      graphics
      hardware-config
      locale
      maintenance
      networking
      packages
      services
      users
    ];
  };
}
