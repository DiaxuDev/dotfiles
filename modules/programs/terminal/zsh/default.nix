{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkOption types;
in
{
  imports = [
    ./options.nix
    ./plugins.nix
  ];

  options.cfg.zsh = {
    rc = mkOption {
      type = types.lines;
      description = "Content to add to .zshrc";
    };
  };

  config = {
    programs.zsh.enable = true;
    users.users.${config.cfg.meta.username}.shell = pkgs.zsh;
    environment.pathsToLink = [ "/share/zsh" ];

    hj = {
      files.".zshenv".text = ''
        if [ -z "$__HJEM_ENV_SOURCED" ]; then
          source ${config.hj.environment.loadEnv}
          export __HJEM_ENV_SOURCED=1
        fi
        export ZDOTDIR=${config.hj.xdg.config.directory}/zsh
      '';

      xdg.config.files."zsh/.zshrc".text = config.cfg.zsh.rc;
    };
  };
}
