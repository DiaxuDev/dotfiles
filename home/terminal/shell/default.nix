{ config, ... }:
{
  imports = [
    ./starship.nix
  ];

  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion.enable = true;

    dotDir = "${config.xdg.configHome}/zsh";
    history = {
      expireDuplicatesFirst = true;
      path = "${config.xdg.dataHome}/zsh_history";
    };
  };
}
