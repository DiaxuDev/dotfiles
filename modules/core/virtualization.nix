{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkMerge mkIf;

  cfg = config.cfg.virtualisation;
in
{
  options.cfg.virtualisation = {
    libvirt.enable = mkEnableOption "libvirt";
    podman.enable = mkEnableOption "podman" // {
      default = true;
    };
  };

  config = mkMerge [
    (mkIf cfg.libvirt.enable {
      programs.virt-manager.enable = true;
      virtualisation = {
        libvirtd = {
          enable = true;
          qemu = {
            package = pkgs.qemu_kvm;
            swtpm.enable = true;
          };
          onBoot = "ignore";
          onShutdown = "shutdown";
        };
      };
      networking.firewall.trustedInterfaces = [ "virbr0" ];
    })

    (mkIf cfg.podman.enable {
      virtualisation = {
        podman = {
          enable = true;
          defaultNetwork.settings.dns_enabled = true;
        };
        containers.registries.settings.registries = {
          search.registries = [ "docker.io" ];
        };
      };
    })
  ];
}
