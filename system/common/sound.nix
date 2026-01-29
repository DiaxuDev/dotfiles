{ pkgs, ... }:
{
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Pavucontrol was technically made for pulseaudio, but it's here until I find a better alternative
  environment.systemPackages = [ pkgs.pavucontrol ];
}
