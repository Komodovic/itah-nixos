{ ... }: {
  flake.modules.nixos.graphics = { pkgs, ... }: {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver
        vpl-gpu-rt
        libvdpau-va-gl
        intel-compute-runtime
        level-zero
      ];
    };
    environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";
  };
}
