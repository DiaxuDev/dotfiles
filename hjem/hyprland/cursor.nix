{ pkgs, ... }:
{
  hj = {
    packages = [ pkgs.banana-cursor ];
    environment.sessionVariables = {
      XCURSOR_THEME = "Banana";
      XCURSOR_SIZE = 40;
    };
  };
}
