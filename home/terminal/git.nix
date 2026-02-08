{
  programs.git = {
    enable = true;

    signing = {
      signByDefault = true; # I want that shiny 'verified' badge in my commits
      key = "D9C37820A27A36F2";
    };

    settings = {
      user = {
        email = "diaxman.gameplay@gmail.com"; # I made that email when I was 9 years old
        name = "DiaxuDev";
      };

      pull.rebase = true;
    };
  };
}
