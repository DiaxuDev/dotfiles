{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  hj = {
    packages = [ inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.twilight ];

    xdg.config.files = {
      "zen/profiles.ini" = {
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

      "zen/default/user.js".text =
        lib.concatMapAttrsStringSep "\n" (name: value: ''user_pref("${name}", ${builtins.toJSON value})'')
          {
            # needed for the userChrome to work
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            "devtools.debugger.remote-enabled" = true;
            "devtools.chrome.enabled" = true;

            # disabling some insane defaults
            "zen.theme.essentials-favicon-bg" = false;
            "zen.urlbar.show-domain-only-in-sidebar" = false;
            "zen.urlbar.replace-newtab" = false;

            "browser.tabs.delayHidingAudioPlayingIconMS" = 300; # looks nicer with the custom userChrome
            "intl.regional_prefs.use_os_locales" = true;
          };

      "zen/default/chrome/userChrome.css".source = ./userChrome.css;
      "zen/default/chrome/img".source = ./img;
    };
  };
}
