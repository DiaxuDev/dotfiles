{
  config,
  pkgs,
  ...
}:
{
  security.pam.services.hyprlock = { };

  hj = {
    packages = [ pkgs.hyprlock ];

    xdg.config.files."hypr/hyprlock.conf".text =
      let
        c = config.cfg.meta.colors.hex' (color: "0xFF${color}");
      in
      ''
        $font = JetBrainsMono NF

        general {
          hide_cursor=true
        }

        background {
          path=~/.local/state/wallpaper
        }

        image {
          monitor=
          size=113
          border_size=0
          halign=left
          path=~/.face.icon
          position=4%, 7.5%
          valign=bottom
        }

        input-field {
          monitor=
          size=300, 60
          check_color=${c.primary}
          dots_center=false
          dots_size=0.100000
          dots_spacing=0.300000
          fade_on_empty=false
          fail_color=${c.red}
          fail_text=Authentication failed...
          font_color=${c.fg2}
          font_family=$font
          halign=left
          hide_input=false
          inner_color=${c.bg0}
          outline_thickness=2
          placeholder_text=Enter password...
          position=11.5%, 7.5%
          valign=bottom
        }

        label {
          monitor=
          color=${c.primary}
          font_family=$font
          font_size=22
          halign=right
          position=-4%, 15%
          text=cmd[update:43200000] date '+%F, %A'
          valign=bottom
        }

        label {
          monitor=
          color=${c.primary}
          font_family=$font
          font_size=65
          halign=right
          position=-4%, 5%
          text=cmd[update:60000] date '+%H:%M'
          valign=bottom
        }

        label {
          monitor=
          color=${c.primary}
          font_family=$font
          font_size=20
          halign=left
          position=11.5%, 14.3%
          text=Welcome, $USER
          valign=bottom
        }
      '';
  };
}
