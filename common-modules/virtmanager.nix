{ pkgs , ... }: {
  environment.systemPackages = with pkgs; [
    libvirt
    qemu
    spice-vdagent
    virt-manager 
  ];      
  virtualisation.libvirtd.enable = true;
  programs.virt-manager = {
    enable = true;
    package = pkgs.virt-manager;
  };
}
