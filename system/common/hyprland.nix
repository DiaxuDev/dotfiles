{ ... }:
{
  programs.hyprland.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  environment.variables.NIXOS_OZONE_WL = "1";
}
