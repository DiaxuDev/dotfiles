{ pkgs, ... }:
{
  fonts = {
    enableDefaultPackages = false; # this adds a lot of ugly fonts that get matched before my fonts

    packages = with pkgs; [
      # default
      libertinus
      noto-fonts
      jetbrains-mono
      noto-fonts-color-emoji

      # compat
      noto-fonts-cjk-sans
      corefonts

      # nerd fonts
      nerd-fonts.jetbrains-mono
      nerd-fonts.symbols-only
    ];

    fontconfig.defaultFonts = {
      serif = [ "Libertinus serif" ];
      sansSerif = [ "Noto Sans" ];
      monospace = [ "JetBrains Mono" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
