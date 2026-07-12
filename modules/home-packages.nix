{ ... }: {
  flake.modules.homeManager.home-packages = { pkgs, ... }: let
    netbeans-wrapped = pkgs.writeShellScriptBin "netbeans" ''
      export _JAVA_AWT_WM_NONREPARENTING=1
      export XCURSOR_SIZE=20
      exec ${pkgs.netbeans}/bin/netbeans "$@"
    '';
  in {
    home.packages = with pkgs; [
      llama-cpp-vulkan
      netbeans-wrapped
      tridactyl-native
    ];
  };
}
