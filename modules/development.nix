{ ... }: {
  flake.modules.nixos.development = {
    programs.git = {
      enable = true;
      config = {
        core.pager = "delta";
        interactive.diffFilter = "delta --color-only";
        delta = {
          navigate = true;
          "side-by-side" = true;
          hyperlinks = true;
          "file-style" = "omit";
          "hunk-header-style" = "omit";
        };
      };
    };
  };
}
