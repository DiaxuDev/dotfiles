{
  i18n =
    let
      us = "en_US.UTF-8";
      pl = "pl_PL.UTF-8";
    in
    {
      defaultLocale = us;
      extraLocales = [ "${pl}/UTF-8" ];

      # I don't want burgur units
      extraLocaleSettings = {
        LC_MEASUREMENT = pl;
        LC_PAPER = pl;
        LC_TIME = pl;
      };
    };
}
