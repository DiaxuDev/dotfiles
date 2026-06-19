{ pkgs, ... }:
{
  programs.virt-manager.enable = true;

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      swtpm.enable = true;
    };
    onBoot = "ignore";
    onShutdown = "shutdown";
  };

  networking.firewall.trustedInterfaces = [ "virbr0" ];
}
