{ ... }: {
  flake.modules.homeManager.starship = {
    programs.starship = {
      enable = true;
      settings = {
        palette = "noctalia";

        palettes.noctalia = {
          blue      = "#458588";
          red       = "#cc241d";
          green     = "#98971a";
          yellow    = "#d79921";
          cyan      = "#689d6a";
          magenta   = "#b16286";
          white     = "#a89984";
          black     = "#282828";

          rosewater = "#fabd2f";
          flamingo  = "#fb4934";
          pink      = "#d3869b";
          mauve     = "#b16286";
          maroon    = "#fb4934";
          peach     = "#fabd2f";
          teal      = "#689d6a";
          sky       = "#8ec07c";
          sapphire  = "#83a598";
          lavender  = "#d3869b";

          text      = "#ebdbb2";
          subtext1  = "#a89984";
          subtext0  = "#928374";

          overlay2  = "#928374";
          overlay1  = "#928374";
          overlay0  = "#282828";
          surface2  = "#282828";
          surface1  = "#282828";
          surface0  = "#282828";
          base      = "#282828";
          mantle    = "#282828";
          crust     = "#282828";
        };
      };
    };
  };
}
