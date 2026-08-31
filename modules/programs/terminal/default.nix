{ inputs', pkgs, ... }:
{
  imports = [
    ./television
    ./zsh
    ./btop.nix
    ./clin.nix
    ./direnv.nix
    ./git.nix
    ./starship.nix
    ./tealdeer.nix
    ./zoxide.nix
  ];

  hj.packages = with pkgs; [
    file # wdym it's not installed by default
    jq
    ripgrep
    fd
    bat
    eza
    inputs'.self.packages.lyrecho
  ];

  programs.nano.enable = false;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
  };
}
