{
  imports = [
    ./dunst.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./keyring.nix
    ./osd.nix
    ./playerctl.nix
    ./polkit.nix
    ./waybar.nix
    ./wl-clip-persist.nix
  ];

  services.udisks2.enable = true;
}
