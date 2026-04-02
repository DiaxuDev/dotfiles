{
  imports = [
    ./hardware-configuration.nix
    ../common
  ];

  networking.hostName = "nixos";

  # I bought the NVIDIA card back when I was using Windows as my daily driver
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = true;
  hardware.nvidia.powerManagement.enable = true;
  services.lact.enable = true;

  # Fix specific suspend/wakeup issue with my motherboard
  # See https://github.com/NixOS/nixos-hardware/blob/master/gigabyte/b550/b550-fix-suspend.nix
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x1022", ATTR{device}=="0x1483", ATTR{power/wakeup}="disabled"
  '';
}
