{
  inputs,
  lib,
  pkgs,
  config,
  ...
}:
{
  nix = {
    channel.enable = false;
    registry = {
      nixpkgs.flake = inputs.nixpkgs;
    };
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      auto-optimise-store = true;
      keep-derivations = true;
      keep-outputs = true;
      use-xdg-base-directories = true;
      flake-registry = ""; # disable default registry file

      substituters = [ "https://cache.nixos.org?priority=10" ];
      trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];
    };
  };

  nixpkgs.config.allowUnfree = true;
  documentation.nixos.enable = false;

  programs.nh = {
    enable = true;
    flake = "/home/${config.cfg.meta.username}/.nixos";
    clean = {
      enable = true;
      extraArgs = "--keep 3 --keep-since 7d";
    };
  };

  _module.args.inputs' =
    let
      system = pkgs.stdenv.hostPlatform.system;
      transposed = [ "packages" ];
    in
    builtins.mapAttrs (_: input: lib.genAttrs transposed (name: input.${name}.${system})) inputs;
}
