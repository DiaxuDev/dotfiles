{ lib, pkgs, ... }:
{
  hj = {
    packages = [ pkgs.thunderbird ];

    files = {
      ".thunderbird/profiles.ini" = {
        generator = lib.generators.toINI { };
        value = {
          General = {
            StartWithLastProfile = 1;
            Version = 2;
          };
          Profile0 = {
            Name = "default";
            Path = "default";
            IsRelative = 1;
            Default = 1;
          };
        };
      };

      ".thunderbird/default/user.js".text =
        lib.concatMapAttrsStringSep "\n" (name: value: ''user_pref("${name}", ${builtins.toJSON value})'')
          {
            "intl.regional_prefs.use_os_locales" = true;
          };
    };
  };
}
