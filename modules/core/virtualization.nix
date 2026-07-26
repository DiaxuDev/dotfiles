{ pkgs, ... }:
{
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

    podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    containers.registries.settings.registries = {
      search.registries = [ "docker.io" ];
    };
  };

  networking.firewall.trustedInterfaces = [ "virbr0" ];
}
