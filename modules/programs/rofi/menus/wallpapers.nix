{
  writeShellApplication,
  netcat,
}:
let
  exclude = [ "diaxuchan_alt.png" ];
  extraFindArgs = builtins.concatStringsSep " " (map (file: "! -name '${file}'") exclude);
in
writeShellApplication {
  name = "change-wallpaper";

  runtimeInputs = [
    netcat
  ];

  text = ''
    dir=''${XDG_DATA_HOME:=$HOME/.local/share}/wallpapers
    choice=$(find "$dir" -maxdepth 1 -type f ${extraFindArgs} -printf '%f\0icon\37%p\n' | rofi -dmenu -show-icons -theme-str 'element{orientation: vertical;} listview{columns: 3; lines: 1; layout: vertical;} element-icon{size: 12em;}')

    if [ -z "$choice" ]; then
        echo "no wallpaper selected"
        exit 1
    fi

    wall_file=''${XDG_STATE_HOME:=$HOME/.local/state}/wallpaper
    ln -sf "$dir/$choice" "$wall_file"
    echo "set_all $wall_file" | nc -U /tmp/chroma.sock
  '';
}
