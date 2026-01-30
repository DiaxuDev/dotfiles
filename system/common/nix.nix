{ ... }:
{
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];

    auto-optimise-store = true;
  };

  nixpkgs.config.allowUnfree = true;

  programs.nh = {
    enable = true;
    flake = "/home/diaxudev/.nixos";
    clean = {
      enable = true;
      extraArgs = "--keep 3 --keep-since 7d";
    };
  };
}
