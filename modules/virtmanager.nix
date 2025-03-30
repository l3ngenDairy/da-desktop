{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    libvirt
    qemu
    spice-vdagent
    virt-manager 
  ];
  
  virtualisation.libvirtd = {
    enable = true;
    onBoot = "start";
    onShutdown = "suspend";
    qemu = {
      ovmf.enable = true;
      runAsRoot = true;
    };
    
    # Ensure the default network is enabled and auto-started
    networks = {
      default = {
        enable = true;
        autoStart = true;
      };
    };
  };
  
  programs.virt-manager = {
    enable = true;
    package = pkgs.virt-manager;
  };
}
