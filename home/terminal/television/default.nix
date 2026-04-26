{ inputs, pkgs, ... }:
{
  imports = [ ./cable ];

  programs.television = {
    enable = true;
    package = inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.television;
  };
}
