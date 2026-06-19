{ config, lib, ... }:
{
  cfg.zsh.rc = lib.mkOrder 510 ''
    setopt SHARE_HISTORY
    setopt HIST_EXPIRE_DUPS_FIRST
    setopt EXTENDED_HISTORY
    setopt HIST_IGNORE_SPACE
    HISTFILE=${config.hj.xdg.data.directory}/zsh_history
  '';
}
