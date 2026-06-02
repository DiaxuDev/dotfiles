{ lib, pkgs, ... }:
let
  omz-sudo = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/f8bf8f0029a475831ebfba0799975ede20e08742/plugins/sudo/sudo.plugin.zsh";
    hash = "sha256-pXylDddgevJlHbVYFRz7L+oBOb8hQbGWi4e7Z9lcLFk=";
  };
in
{
  cfg.zsh.rc = lib.mkOrder 520 ''
    source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    ZSH_AUTOSUGGEST_STRATEGY=history

    source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

    source ${omz-sudo}
  '';
}
