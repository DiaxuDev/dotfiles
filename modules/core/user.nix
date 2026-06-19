{ config, ... }:
{
  users.users.${config.cfg.meta.username} = {
    isNormalUser = true;
    initialHashedPassword = "$y$j9T$8asz11IG7BoMNoTdMPHF4/$gEZX0zl3HmuOkenkRWLh.D6WOj6jalRqDeS5DhNEkN4";
    extraGroups = [ "wheel" ];
  };
}
