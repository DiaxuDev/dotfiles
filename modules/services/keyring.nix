{
  # GPG
  programs.gnupg.agent.enable = true;

  # GNOME Keyring
  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true; # gui for gnome keyring
  security.pam.services.login.enableGnomeKeyring = true;

  # taken from fazzi's config
  hj.systemd.services.gnome-keyring = {
    description = "GNOME Keyring Daemon";
    after = [ "graphical-session.target" ];
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      Restart = "always";
      ExecStart = "/run/wrappers/bin/gnome-keyring-daemon --start --foreground --components=secrets,pkcs11";
    };
  };
}
