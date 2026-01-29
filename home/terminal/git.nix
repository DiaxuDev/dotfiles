{ ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        email = "diaxman.gameplay@gmail.com"; # I made that email when I was 9 years old
        name = "DiaxuDev";
      };

      pull.rebase = true;
    };
  };
}
