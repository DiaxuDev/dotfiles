{ pkgs, ... }:
{
  fonts = {
    enableDefaultPackages = false; # this adds a lot of ugly fonts that get matched before my fonts

    packages = with pkgs; [
      libertinus
      noto-fonts
      noto-fonts-color-emoji
      nerd-fonts.jetbrains-mono
      corefonts
    ];

    fontconfig.defaultFonts = {
      serif = [ "Libertinus serif" ];
      sansSerif = [ "Noto Sans" ];
      monospace = [ "JetBrainsMono NF" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
