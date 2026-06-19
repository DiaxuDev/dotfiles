{ lib, pkgs, ... }:
{
  hj = {
    packages = [ pkgs.direnv ];

    xdg.config.files."direnv/lib/nix-direnv.sh".source = "${pkgs.nix-direnv}/share/nix-direnv/direnvrc";
  };

  cfg.zsh.rc = ''eval "$(${lib.getExe pkgs.direnv} hook zsh)"'';
}
