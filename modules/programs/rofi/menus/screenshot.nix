{
  writeShellApplication,
  hyprland,
  jq,
  grim,
  slurp,
  still,
  wl-clipboard,
  rofiCmd,

  borderColor ? "#000000ff",
}:
writeShellApplication {
  name = "screenshot";

  runtimeInputs = [
    hyprland
    jq
    grim
    slurp
    still
    wl-clipboard
  ];

  text = ''
    # variables
    full="󰊓"
    window="󱂬"
    area="󰏫"

    run_rofi() {
        echo -e "$area\n$window\n$full" | ${rofiCmd "Screenshot" 3}
    }

    screenshot() {
        case $(run_rofi) in
            "$full")
                local output
                output=$(hyprctl monitors -j | jq 'first(.[] | select(.focused)).name' -r)
                grim -t png -o "$output" -
                ;;
            "$window")
                local window
                window=$(hyprctl activewindow -j | jq '.stableId' -r)
                grim -t png -T "$window" -
                ;;
            "$area")
                still -c "slurp -b '#000000aa' -s '#00000000' -c '${borderColor}' | grim -t png -g- -"
                ;;
        esac
    }

    case $1 in
        edit)
            screenshot | satty --filename -
            ;;
        copy)
            screenshot | wl-copy
            ;;
        *)
            echo "Usage: $0 <edit | copy>"
            exit 1
    esac
  '';
}
