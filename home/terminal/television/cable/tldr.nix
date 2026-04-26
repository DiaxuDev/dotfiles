{
  programs.television.channels.tldr = {
    metadata = {
      name = "tldr";
      description = "Browse and preview TLDR help pages for command-line tools";
      requirements = [ "tldr" ];
    };
    source.command = "tldr --list";
    preview.command = "tldr '{0}' --color always";
    actions.execute = {
      description = "Open the selected TLDR page";
      command = "tldr '{0}'";
      mode = "execute";
    };
  };
}
