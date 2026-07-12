{ ... }: {
  flake.modules.nixos.hardware-config = { ... }: {
    fileSystems."/" = {
      device = "/dev/disk/by-uuid/17e70404-de90-4089-b355-d6230885138b";
      fsType = "ext4";
    };
    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/A965-1CA0";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };
    swapDevices = [ ];
    nixpkgs.hostPlatform = "x86_64-linux";
    hardware.cpu.intel.npu.enable = true;
    hardware.cpu.intel.updateMicrocode = true;
    hardware.enableRedistributableFirmware = true;
  };
}
