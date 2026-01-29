{ pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      libertinus
      noto-fonts
      noto-fonts-color-emoji
      nerd-fonts.jetbrains-mono
    ];

    fontconfig.defaultFonts = {
      serif = [ "Libertinus serif" ];
      sansSerif = [ "Noto Sans" ];
      monospace = [ "JetBrains Mono Nerd Font" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
