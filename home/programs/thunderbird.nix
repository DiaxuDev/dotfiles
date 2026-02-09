{
  programs.thunderbird = {
    enable = true;

    profiles.default = {
      isDefault = true;

      settings = {
        "intl.regional_prefs.use_os_locales" = true;
      };
    };
  };
}
