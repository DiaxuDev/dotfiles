{ pkgs, ... }:
let
  pkg = pkgs.banana-cursor;
  name = "Banana";
  size = 40;
in
{
  hj = {
    packages = [ pkg ];
    environment.sessionVariables = {
      XCURSOR_THEME = name;
      XCURSOR_SIZE = size;
    };

    xdg.data.files."icons/${name}".source = "${pkg}/share/icons/${name}";
  };

  cfg.gtk.cursorTheme = { inherit name size; };
}
