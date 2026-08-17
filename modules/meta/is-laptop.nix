{ lib, ... }:
{
  options.cfg.meta.isLaptop = lib.mkOption {
    description = "Whether the machine is a laptop.";
    default = false;
    type = lib.types.bool;
  };
}
