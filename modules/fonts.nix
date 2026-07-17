{ ... }: {
  flake.modules.nixos.fonts = { pkgs, lib, ... }: let
    geometric-sans-serif = pkgs.stdenv.mkDerivation {
      pname = "geometric-sans-serif";
      version = "1.0";
      src = pkgs.fetchzip {
        url = "https://font.download/dl/font/geometric-sans-serif-v1.zip";
        hash = "sha256-QOScRv6M3Ua4w3+LCEFNmW+l9++K5WlQedop5BeJgpA=";
        stripRoot = false;
      };
      installPhase = ''
        mkdir -p $out/share/fonts/opentype
        cp *.otf $out/share/fonts/opentype/
      '';
      meta = with lib; {
        description = "Geometric Sans Serif v1";
        homepage = "https://font.download/font/geometric-sans-serif-v1";
        license = licenses.free;
        platforms = platforms.all;
      };
    };
  in {
    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      corefonts
      vista-fonts
      poppins
      montserrat
      geometric-sans-serif
    ];
  };
}
