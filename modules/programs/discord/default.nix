{ lib, pkgs, ... }:
{
  hj = {
    packages = [ pkgs.vesktop ];

    xdg.config.files = {
      "vesktop/themes/system24.css".source = ./system24.css;

      "vesktop/settings/settings.json" = {
        generator = lib.generators.toJSON { };
        value = {
          enabledThemes = [ "system24.css" ];

          plugins = {
            BetterGifAltText.enabled = true;
            BetterGifPicker.enabled = true; # TODO: port FavoriteMedia BD plugin to vencord
            BetterUploadButton.enabled = true;
            ClearURLs.enabled = true;
            MessageClickActions.enabled = true;
            NoF1.enabled = true;
            OpenInApp.enabled = true;
            QuickReply.enabled = true;
            TypingTweaks.enabled = true;
          };
        };
      };
    };
  };
}
