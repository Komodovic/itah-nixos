{ ... }: {
  flake.modules.homeManager.fastfetch = {
    xdg.configFile."fastfetch/config.jsonc".source = ./fastfetch-13.jsonc;
  };
}
