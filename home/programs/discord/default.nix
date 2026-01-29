{ ... }:
{
  programs.vesktop = {
    enable = true;
    vencord = {
      themes = {
        system24 = ./system24.css;
      };
      settings.enabledThemes = [ "system24.css" ];
    };
  };
}
