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
    systemd.services.mysql.wantedBy = lib.mkForce [ ];
    services.fwupd.enable = true;
    hardware.bluetooth.enable = true;
    services.power-profiles-daemon.enable = true;
    services.fstrim.enable = true;
    services.fprintd.enable = true;
    security.pam.services.login.fprintAuth = true;
    security.pam.services.sudo.fprintAuth = true;
  };
}
