{ lib, config, ... }:
let
  inherit (lib)
    mkOption
    types
    mapAttrsRecursive
    mkDefault
    concatLines
    genAttrs
    ;

  inherit (lib.generators) toLua;

  bindModule = types.submodule {
    options = {
      key = mkOption {
        type = types.str;
        description = "The key to bind to.";
      };
      exec = mkOption {
        type = types.str;
        description = "Lua script to execute.";
      };
      flags = mkOption {
        type = types.listOf types.str;
        description = "Hyprland bind flags to set.";
      };
    };
  };
in
{
  options.cfg.hyprland = {
    binds = mkOption {
      type = types.listOf bindModule;
      default = [ ];
      description = "Hyprland keybinds.";
    };
    windowRules = mkOption {
      type = types.listOf (types.attrsOf types.anything);
      description = "Hyprland window rules.";
    };
    settings = mkOption {
      type = types.attrsOf types.anything;
      description = "Hyprland settings.";
    };
  };

  config = {
    cfg.hyprland.settings = mapAttrsRecursive (_: mkDefault) {
      general = {
        gaps_in = 0;
        gaps_out = 0;
        border_size = 1;
        col =
          let
            inherit (lib) removePrefix;
            rgb = c: "rgb(${removePrefix "#" config.cfg.meta.colors.${c}})";
          in
          {
            inactive_border = rgb "base03";
            active_border = rgb "base0B";
          };
      };
      animations.enabled = false;
      input = {
        kb_layout = "pl";
        kb_options = "kpdl:dot";
        numlock_by_default = true;
      };
      debug.disable_logs = false;
      debug.disable_time = false;
    };

    hj.xdg.config.files."hypr/hyprland.lua" = {
      text = ''
        hl.on("hyprland.start", function() hl.exec_cmd("systemctl --user start hyprland-session.target") end)
        hl.on("hyprland.shutdown", function() hl.exec_cmd("systemctl --user stop hyprland-session.target") end)

        hl.config(${toLua { } config.cfg.hyprland.settings})

        ${concatLines (map (rule: "hl.window_rule(${toLua { } rule})") config.cfg.hyprland.windowRules)}

        hl.bind("SUPER + return", hl.dsp.exec_raw("kitty"))
        hl.bind("SUPER + e", hl.dsp.exec_raw("thunar"))
        hl.bind("SUPER + r", hl.dsp.exec_raw("rofi -show drun"))

        hl.bind("SUPER + q", hl.dsp.window.close())

        hl.bind("SUPER + left", hl.dsp.focus({ direction = "left" }))
        hl.bind("SUPER + right", hl.dsp.focus({ direction = "right" }))
        hl.bind("SUPER + up", hl.dsp.focus({ direction = "up" }))
        hl.bind("SUPER + down", hl.dsp.focus({ direction = "down" }))

        hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
        hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

        hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
        hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

        ${concatLines (
          map (
            bind:
            ''hl.bind("${bind.key}", ${bind.exec}, ${
              toLua { multiline = false; } (genAttrs bind.flags (_: true))
            })''
          ) config.cfg.hyprland.binds
        )}

        for i = 1, 10 do
            local key = i % 10 -- 10 maps to key 0
            hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = i}))
            hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
        end
      '';
    };
  };
}
