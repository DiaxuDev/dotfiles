{ inputs, lib, ... }:
let
  inherit (lib.modules) mkAliasOptionModule;
  username = "diaxudev"; # TODO: replace this with systemwide option
in
{
  imports = [
    inputs.hjem.nixosModules.default
    (mkAliasOptionModule [ "hj" ] [ "hjem" "users" username ])
    ../../hjem
  ];

  hjem = {
    clobberByDefault = true;
    users.${username} = {
      user = username;
      directory = "/home/${username}";
    };
  };
}
