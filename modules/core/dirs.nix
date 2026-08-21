{
  lib,
  config,
  ...
}:
let
  inherit (builtins) isAttrs;
  inherit (lib) concatLines;
  inherit (lib.generators) toKeyValue;

  home = config.hj.directory;
in
{
  hj = {
    environment.sessionVariables =
      let
        xdg = config.hj.xdg;
      in
      {
        CUDA_CACHE_PATH = "${xdg.cache.directory}/nv";
        CARGO_HOME = "${xdg.data.directory}/cargo";
        LESSHISTFILE = "${xdg.data.directory}/less/history";
        GNUPGHOME = "${xdg.data.directory}/gnupg";
        WINEPREFIX = "${xdg.data.directory}/wine";
        NODE_REPL_HISTORY = "${xdg.data.directory}/node_repl_history";
        _JAVA_OPTIONS = "-Djava.util.prefs.userRoot=${xdg.data.directory}/java";

        # DuckDB for some reason allows custom dir only for the history file
        # ~/.duckdbrc and ~/.duckdb/ have to be in the home dir
        # Technically I could probably circumvent this by wrapping
        # duckdb ans setting HOME env var to XDG_DATA_HOME/duckdb but who cares
        DUCKDB_HISTORY = "${xdg.data.directory}/duckdb/history";
      };

    xdg.config.files = {
      "user-dirs.dirs" = {
        generator = toKeyValue { mkKeyValue = k: v: "XDG_${k}_DIR=\"${home}/${v}\""; };
        value = {
          DOWNLOAD = "Downloads";
          DOCUMENTS = "Documents";
          PICTURES = "Pictures";
          PROJECTS = "projects";
        };
      };

      "gtk-3.0/bookmarks".text =
        let
          mkPath = dir: "file://${home}/${dir}";
          mkBookmark = line: if isAttrs line then "${mkPath line.path} ${line.name}" else mkPath line;

          bookmarks = [
            {
              path = ".nixos";
              name = "NixOS";
            }
            {
              path = "projects";
              name = "Projects";
            }
            "Pictures"
            "Downloads"
            "Documents"
          ];
        in
        concatLines (map mkBookmark bookmarks);
    };
  };
}
