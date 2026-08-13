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
          email = "diaxudev@gmail.com"; # GMAIL has let me change my email
          name = "DiaxuDev";
          signingKey = "D9C37820A27A36F2";
        };
      };
    };
  };
}
