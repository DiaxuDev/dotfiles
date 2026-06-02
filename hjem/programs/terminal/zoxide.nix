{ lib, pkgs, ... }:
{
  hj.packages = [ pkgs.zoxide ];
  cfg.zsh.rc = ''eval "$(${lib.getExe pkgs.zoxide} init zsh)"'';
}
