{ pkgs, ... }:
{
  imports = [
    ./menus
    ./theme.nix
  ];

  hj = {
    packages = [
      (pkgs.rofi.override {
        plugins = with pkgs; [
          rofi-emoji
        ];
      })
    ];

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

  cfg.hyprland.binds = [
    {
      key = "SUPER + r";
      exec = ''hl.dsp.exec_raw("rofi -show drun")'';
    }
    {
      key = "SUPER + period";
      exec = ''hl.dsp.exec_raw("rofi -show emoji -modi emoji")'';
    }
  ];
}
