{ inputs, config, ... }:
let
  cfg = config.programs.zen-browser;
in
{
  imports = [ inputs.zen-browser.homeModules.twilight ];

  programs.zen-browser = {
    enable = true;

    profiles.default = {
      settings = {
        # needed for the userChrome to work
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "devtools.debugger.remote-enabled" = true;
        "devtools.chrome.enabled" = true;

        # disabling some insane defaults
        "zen.theme.essentials-favicon-bg" = false;
        "zen.urlbar.show-domain-only-in-sidebar" = false;
        "zen.urlbar.replace-newtab" = false;

        "browser.tabs.delayHidingAudioPlayingIconMS" = 300; # looks nicer with the custom userChrome
      };

      userChrome = import ./userChrome.nix;
    };
  };

  home.file."${cfg.profilesPath}/default/chrome/img" = {
    source = ./assets;
  };
}
