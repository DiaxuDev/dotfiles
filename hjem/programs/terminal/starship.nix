{ lib, pkgs, ... }:
{
  hj.packages = [ pkgs.starship ];
  cfg.zsh.rc = ''
    if [[ $TERM != "DUMB" ]]; then
      eval "$(${lib.getExe pkgs.starship} init zsh)"
    fi
  '';
}
