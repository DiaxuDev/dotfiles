{ config, ... }:
{
  imports = [
    ./direnv.nix
    ./plugins.nix
    ./starship.nix
  ];

  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    dotDir = "${config.xdg.configHome}/zsh";
    history = {
      expireDuplicatesFirst = true;
      path = "${config.xdg.dataHome}/zsh_history";
    };

    shellAliases = {
      ".." = "cd ..";
    };
  };
}
