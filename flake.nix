{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
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
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        modules = [ ./system/hosts/nixos.nix ];
        specialArgs = { inherit inputs; };
      };

      packages.${system} = {
        lyrecho = pkgs.callPackage ./pkgs/lyrecho { };
        television = pkgs.callPackage ./pkgs/television { };
      };

      formatter.${system} = pkgs.nixfmt-tree; # TODO: use something like forAllSystems
    };
}
