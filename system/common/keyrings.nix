{
  # GPG
  programs.gnupg.agent.enable = true;

  # GNOME Keyring
  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true; # gui for gnome keyring
  security.pam.services.login.enableGnomeKeyring = true;
}
