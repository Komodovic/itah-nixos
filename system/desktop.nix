{ config, pkgs, lib, niri, ... }: {
  programs.niri.enable = true;
  programs.niri.package = niri.packages.${pkgs.stdenv.hostPlatform.system}.niri;

  programs.noctalia.enable = true;

  environment.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt6ct";
    NIXOS_OZONE_WL = "1";
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "18";
  };
}
