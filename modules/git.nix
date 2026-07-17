{ ... }: {
  flake.modules.homeManager.git = {
    programs.git = {
      enable = true;
      settings = {
        core.pager = "delta";
      };
    };
    programs.delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        navigate = true;
        side-by-side = true;
        hyperlinks = true;
        file-style = "omit";
        hunk-header-style = "omit";
      };
    };
  };
}
