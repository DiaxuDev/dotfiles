{
  # I need to limit powerdraw of my gpu to prevent it from blackscreening
  services.lact.enable = true;

  # Fix specific suspend/wakeup issue with my motherboard
  # See https://github.com/NixOS/nixos-hardware/blob/master/gigabyte/b550/b550-fix-suspend.nix
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x1022", ATTR{device}=="0x1483", ATTR{power/wakeup}="disabled"
  '';

  cfg.hardware.nvidia.enable = true;
}
