{ lib, pkgs, ... }:
{
  hj = {
    packages = [ pkgs.starship ];

    xdg.config.files."starship.toml" = {
      generator = (pkgs.formats.toml { }).generate "starship.toml";
      value =
        let
          styled = text: style: "[${text}](${style})";
          styled' = text: styled text "$style";
        in
        {
          format =
            let
              left = [
                "$directory"
                "$git_branch"
                "$git_commit"
                "$git_state"
                "$git_status"
                "$direnv"
                "$nix_shell"
              ];

              right = [
                "$shlvl"
                "$cmd_duration"
                "$status"
              ];
            in
            "${lib.concatStrings left}$fill${lib.concatStrings right}$line_break$character";

          directory = {
            format = styled "$read_only" "$read_only_style" + styled' "$path ";
            read_only = " ";
          };

          direnv = {
            disabled = false;
            format = styled' "$symbol$loaded ";
          };

          nix_shell = {
            format = "via ${styled' "$symbol$name"} ";
            symbol = " ";
          };

          status = {
            disabled = false;
            format = styled "  $status" "red";
          };

          cmd_duration.format = styled' "  $duration";

          shlvl = {
            disabled = false;
            format = styled' " $symbol$shlvl";
            symbol = " ";
          };

          character.format = styled "𝛌 " "bold blue";

          fill.symbol = " ";
        };
    };
  };

  cfg.zsh.rc = ''
    if [[ $TERM != "DUMB" ]]; then
      eval "$(${lib.getExe pkgs.starship} init zsh)"
    fi
  '';
}
