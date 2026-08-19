{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    hjem = {
      url = "github:feel-co/hjem";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "";
      };
    };
  };
  outputs =
    inputs@{
      nixpkgs,
      ...
    }:
    let
      systems = [ "x86_64-linux" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
    in
    {
      nixosConfigurations = import ./hosts inputs;

      lib = import ./lib nixpkgs.lib;

      packages = forAllSystems (pkgs: {
        lyrecho = pkgs.callPackage ./pkgs/lyrecho { };
        television = pkgs.callPackage ./pkgs/television { };
      });

      formatter = forAllSystems (pkgs: pkgs.nixfmt-tree);
    };
}
