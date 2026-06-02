{ pkgs, ... }:
{
  imports = [
    ./menus
    ./theme.nix
  ];

  hj = {
    packages = [ pkgs.rofi ];

    xdg.config.files."rofi/config.rasi".text = ''
      configuration {
        case-sensitive: false;
        cycle: true;
        font: "JetBrainsMono Nerd Font 10";
        show-icons: true;
      }

      @theme "theme"
    '';
  };
}
