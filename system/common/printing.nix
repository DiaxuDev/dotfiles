{pkgs, ...}:
{
  services.printing = {
    enable = true;
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.sane-airscan ];
  };

  services.udev.packages = [ pkgs.sane-airscan ];
  users.users.diaxudev.extraGroups = [ "scanner" "lp" ];
  environment.systemPackages = [ pkgs.kdePackages.skanpage ];
}
