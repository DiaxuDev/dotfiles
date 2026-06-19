{
  lib,
  pkgs,
  ...
}:
{
  hj = {
    packages = [ pkgs.git ];

    xdg.config.files."git/config" = {
      generator = lib.generators.toGitINI;
      value = {
        commit.gpgSign = true;
        tag.gpgSign = true;
        pull.rebase = true; # no ugly merge commits in history
        user = {
          email = "diaxman.gameplay@gmail.com"; # I made that email when I was 9 years old
          name = "DiaxuDev";
          signingKey = "D9C37820A27A36F2";
        };
      };
    };
  };
}
