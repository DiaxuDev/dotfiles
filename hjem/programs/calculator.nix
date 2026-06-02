{ pkgs, ... }:
{
  # calc is slang for calculator btw
  hj.packages = with pkgs; [
    libqalculate
    qalculate-qt
  ];

  cfg.hyprland.binds = [
    {
      key = "XF86Calculator";
      exec = ''hl.dsp.exec_raw("qalculate-qt")'';
    }
  ];
}
