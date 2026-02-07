{
  programs.vesktop = {
    enable = true;
    vencord = {
      themes = {
        system24 = ./system24.css;
      };
      settings = {
        enabledThemes = [ "system24.css" ];

        plugins = {
          BetterGifAltText.enabled = true;
          BetterGifPicker.enabled = true; # TODO: port FavoriteMedia BD plugin to vencord
          BetterUploadButton.enabled = true;
          ClearURLs.enabled = true;
          MessageClickActions.enabled = true;
          NoF1.enabled = true;
          QuickReply.enabled = true;
          TypingTweaks.enabled = true;
        };
      };
    };
  };
}
