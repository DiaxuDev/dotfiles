{
  inputs',
  pkgs,
  ...
}:
{
  hj = {
    packages = [ inputs'.clin.packages.default ];

    xdg.config.files."clin/config.toml" = {
      generator = (pkgs.formats.toml { }).generate "config.toml";
      value = {
        storage_path = "~/Documents/clin";
        goals.enabled = false;
      };
    };
  };
}
