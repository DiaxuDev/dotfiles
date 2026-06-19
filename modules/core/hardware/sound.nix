{ pkgs, ... }:
{
  services.pipewire = {
    enable = true;
    pulse.enable = true;

    # Stolen from NotAShelf in hopes of fixing my spotify sounding like it's under the water
    wireplumber.extraConfig = {
      "10-bluez" = {
        "monitor.bluez.rules" = [
          {
            matches = [ { "device.name" = "~bluez_card.*"; } ];
            actions = {
              update-props = {
                "bluez5.roles" = [
                  "hsp_hs"
                  "hsp_ag"
                  "hfp_hf"
                  "hfp_ag"
                ];
                "bluez5.enable-msbc" = true;
                "bluez5.enable-sbc-xq" = true;
                "bluez5.enable-hw-volume" = true;
                "bluez5.a2dp.ldac.quality" = "hq";
              };
            };
          }
        ];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    pwvucontrol
    qpwgraph
  ];
}
