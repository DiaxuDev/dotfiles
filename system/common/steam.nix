{ pkgs, ... }:
{
  programs = {
    steam = {
      enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };

    gamemode = {
      enable = true;
      enableRenice = true;
      settings.general = {
        renice = 15;
        softrealtime = "auto";
      };
    };
  };

}
