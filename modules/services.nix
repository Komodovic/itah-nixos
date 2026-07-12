{ ... }: {
  flake.modules.nixos.services = { pkgs, lib, ... }: {
    services.upower.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    services.mysql = {
      enable = true;
      package = pkgs.mariadb;
    };
    services.mysql.ensureDatabases = [ "itah" ];
    services.mysql.ensureUsers = [{
      name = "itah";
      ensurePermissions = { "itah.*" = "ALL PRIVILEGES"; };
    }];
    systemd.services.mysql.wantedBy = lib.mkForce [ ];
    services.fwupd.enable = true;
    hardware.bluetooth.enable = true;
    powerManagement.powertop.enable = true;
    services.power-profiles-daemon.enable = true;
    services.thermald.enable = true;
    services.fstrim.enable = true;
  };
}
