{ pkgs, ... }:
{
  programs.zsh.plugins = [
    {
      name = "omz-sudo";
      file = "sudo.plugin.zsh";
      src = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/refs/heads/master/plugins/sudo/sudo.plugin.zsh";
        hash = "sha256-e5XU1bdWZAVGMAMKcKNXRGEzgwLaYijyCRN23WLJcGk=";

        downloadToTemp = true;
        recursiveHash = true;
        postFetch = ''
          mkdir "$out"
          mv "$downloadedFile" "$out/sudo.plugin.zsh"
        '';
      };
    }
  ];
}
