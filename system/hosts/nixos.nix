{ ... }:
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
}
