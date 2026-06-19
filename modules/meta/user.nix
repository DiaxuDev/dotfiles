{ lib, ... }:
{
  options = {
    cfg.meta.username = lib.options.mkOption {
      description = "The name of the main user account";
      type = lib.types.str;

      default = "diaxudev";
    };
  };
}
