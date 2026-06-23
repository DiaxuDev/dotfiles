{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    hjem = {
      url = "github:feel-co/hjem";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nix-darwin.follows = "";
      };
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake?rev=7e1dae7aa169ad02f18ca11da247008181b2dc7f";
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
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = import ./hosts inputs;

      packages.${system} = {
        lyrecho = pkgs.callPackage ./pkgs/lyrecho { };
        television = pkgs.callPackage ./pkgs/television { };
      };

      formatter.${system} = pkgs.nixfmt-tree; # TODO: use something like forAllSystems
    };
}
