{ config, pkgs, lib, ... }: {
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

  systemd.user.services.polkit-gnome = {
    description = "PolicyKit Authentication Agent";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];
  };
  hardware.bluetooth.enable = true;

  powerManagement.powertop.enable = true;

  services.power-profiles-daemon.enable = true;
  services.thermald.enable = true;

  services.fstrim.enable = true;
}
