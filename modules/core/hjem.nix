{
  inputs,
  lib,
  config,
  ...
}:
let
  inherit (lib.modules) mkAliasOptionModule;
  inherit (config.cfg.meta) username;
in
{
  imports = [
    inputs.hjem.nixosModules.default
    (mkAliasOptionModule [ "hj" ] [ "hjem" "users" username ])
  ];

  hjem = {
    clobberByDefault = true;
    users.${username} = {
      user = username;
      directory = "/home/${username}";
    };
  };
}
