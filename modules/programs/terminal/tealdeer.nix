{ pkgs, ... }:
{
  hj = {
    packages = [ pkgs.tealdeer ];

    xdg.config.files."tealdeer/config.toml" = {
      generator = (pkgs.formats.toml { }).generate "config.toml";
      value = {
        display.use_pager = true;
      };
    };
  };
}
