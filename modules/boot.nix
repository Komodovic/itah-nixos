{ ... }: {
  flake.modules.nixos.boot = { pkgs, ... }: {
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.loader.systemd-boot.configurationLimit = 20;
    boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" ];
    boot.kernelModules = [ "kvm-intel" ];
    zramSwap.enable = true;
    zramSwap.memoryMax = 4294967296;
    boot.tmp.cleanOnBoot = true;
  };
}
