{ inputs, ... }: let
  gruvbox-dark = pkgs: pkgs.stdenv.mkDerivation {
    pname = "gruvbox-wallpapers-dark";
    version = inputs.gruvbox-wallpapers.shortRev or "dev";
    src = inputs.gruvbox-wallpapers;
    installPhase = ''
      mkdir -p $out
      find wallpapers -type f ! -path "*/light/*" -exec cp {} $out/ \;
    '';
  };
in {
  flake.modules.homeManager.wallpapers = { pkgs, ... }: {
    home.file."wallpapers/gruvbox" = {
      source = gruvbox-dark pkgs;
      recursive = true;
    };
  };
}
