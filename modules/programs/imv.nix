{ lib, pkgs, ... }: {
  hj = {
    packages = [ pkgs.imv ];
    xdg.config.files."imv/config" = {
      generator = lib.generators.toINI { };
      value = {
        binds = {
          "<Ctrl+c>" = "exec ${lib.getExe' pkgs.wl-clipboard "wl-copy"} < $imv_current_file";
        };
      };
    };
  };
}
