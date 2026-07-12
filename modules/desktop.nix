{ ... }: {
  flake.modules.nixos.desktop = { inputs, pkgs, ... }: {
    imports = [ inputs.noctalia.nixosModules.default ];

    programs.dconf.enable = true;
    programs.fuse.enable = true;

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-gnome xdg-desktop-portal-gtk ];
    };

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

    programs.niri.enable = true;
    programs.niri.package = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.niri;
    programs.noctalia.enable = true;

    environment.sessionVariables = {
      QT_QPA_PLATFORMTHEME = "qt6ct";
      NIXOS_OZONE_WL = "1";
      XCURSOR_THEME = "Bibata-Modern-Classic";
      XCURSOR_SIZE = "18";
    };
  };

  flake.modules.homeManager.desktop = {
    xdg.configFile."niri/config.kdl".source = ./niri-config.kdl;
  };
}
