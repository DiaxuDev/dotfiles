{ lib, ... }:
let
  inherit (lib) mkOption types;
  inherit (builtins) mapAttrs;
in
{
  options.cfg.meta.colors = mkOption {
    description = "An attribute set containing colors";
    type =
      let
        mkColorOption =
          name:
          mkOption {
            description = "Hex string without the leading hashtag of the ${name} color";
            type = types.strMatching "[0-9a-f]{6}";
          };

        mkColorOptionFallback = name: fallback: mkColorOption name // { default = fallback; };
      in
      types.submodule (
        { config, ... }: {
          options = {
            bg0 = mkColorOption "background 0";
            bg1 = mkColorOption "background 1";
            bg2 = mkColorOption "background 2";
            bg3 = mkColorOption "background 3";

            fg0 = mkColorOption "foreground 0";
            fg1 = mkColorOption "foreground 1";
            fg2 = mkColorOption "foreground 2";
            fg3 = mkColorOption "foreground 3";

            black = mkColorOption "black";
            red = mkColorOption "red";
            green = mkColorOption "green";
            yellow = mkColorOption "yellow";
            blue = mkColorOption "blue";
            magenta = mkColorOption "magenta";
            cyan = mkColorOption "cyan";
            white = mkColorOption "white";

            bright-black = mkColorOptionFallback "bright black" config.black;
            bright-red = mkColorOptionFallback "bright red" config.red;
            bright-green = mkColorOptionFallback "bright green" config.green;
            bright-yellow = mkColorOptionFallback "bright yellow" config.yellow;
            bright-blue = mkColorOptionFallback "bright blue" config.blue;
            bright-magenta = mkColorOptionFallback "bright magenta" config.magenta;
            bright-cyan = mkColorOptionFallback "bright cyan" config.cyan;
            bright-white = mkColorOptionFallback "bright white" config.white;

            primary = mkColorOption "primary";
          };
        }
      );

    apply =
      let
        mkConverted = colors: convert: mapAttrs (_: color: convert color) colors;
        mkFormat = colors: convert: mkConverted colors convert // { __functor = mkConverted; };
      in
      colors: {
        hex' = colors // {
          __functor = mkConverted;
        };
        hex = mkFormat colors (color: "#${color}");
      };

    default = (
      { config, ... }: {
        bg0 = "292828";
        bg1 = "32302f";
        bg2 = "504945";
        bg3 = "665c54";

        fg0 = "bdae93";
        fg1 = "ddc7a1";
        fg2 = "ebdbb2";
        fg3 = "fbf1c7";

        black = config.bg2;
        red = "ea6962";
        green = "a9b665";
        yellow = "d8a657";
        blue = "7daea3";
        magenta = "d3869b";
        cyan = "89b482";
        white = config.fg1;

        bright-black = config.bg3;
        bright-white = config.fg3;

        primary = config.green;
      }
    );
  };
}
