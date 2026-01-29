{ ... }:
{
  programs.zsh.enable = true;
  environment.pathsToLink = [ "/share/zsh" ]; # Link zsh completions
}
