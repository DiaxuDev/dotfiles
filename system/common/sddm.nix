{ pkgs, ... }:
let
  theme = pkgs.sddm-astronaut;
in
{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;

    theme = "${theme}/share/sddm/themes/sddm-astronaut-theme";
    extraPackages = theme.propagatedBuildInputs; # propagatedBuildImputs contains all the qt libs that the theme needs

    # FIXME: cursor still not visible, maybe because of my nvidia gpu
    settings.Theme = {
      CursorTheme = "Banana";
      CursorSize = 24;
    };
  };
}
