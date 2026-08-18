{
  imports = [
    ./dunst.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./keyring.nix
    ./osd.nix
    ./playerctl.nix
    ./polkit.nix
    ./waybar.nix
    ./wl-clip-persist.nix
    ./wpaperd.nix
  ];

  services.udisks2.enable = true;
}
