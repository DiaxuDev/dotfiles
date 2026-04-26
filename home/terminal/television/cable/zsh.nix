{ config, ... }:
{
  programs.television.channels.zsh-history = {
    metadata = {
      name = "zsh-history";
      description = "A channel to select from your zsh history";
      requirements = [ "zsh" ];
    };
    source = {
      command = "sed '1!G;h;$!d' ${config.programs.zsh.history.path}";
      display = "{split:;:1..}";
      output = "{split:;:1..}";
      no_sort = true;
      frecency = false;
    };
    actions.execute = {
      description = "Execute the selected command";
      command = "zsh -c '{split:;:1..}'";
      mode = "execute";
    };
  };
}
