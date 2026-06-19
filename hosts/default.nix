inputs:
let
  inherit (builtins) attrNames readDir;
  inherit (inputs.nixpkgs.lib) filterAttrs genAttrs nixosSystem;

  hostNames = attrNames (filterAttrs (_: v: v == "directory") (readDir ./.));

  mkHost =
    name:
    nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        { networking.hostName = name; }
        ../modules
      ]
      ++ map (v: ./${name}/${v}) (attrNames (readDir ./${name}));
    };
in
genAttrs hostNames mkHost
