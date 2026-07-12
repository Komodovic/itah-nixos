{ ... }: {
  flake.modules.nixos.users = { pkgs, ... }: {
    users.users.itah = {
      isNormalUser = true;
      shell = pkgs.fish;
      ignoreShellProgramCheck = true;
      extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
    };
  };
}
