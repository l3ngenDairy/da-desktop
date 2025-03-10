{ config, pkgs, lib, ... }:

{
  # Enable NVIDIA graphics drivers
  hardware.graphics.enable = true;

  # Specify NVIDIA as the video driver for X server
  services.xserver.videoDrivers = [ "nvidia" ];

  # NVIDIA-specific configuration
  hardware.nvidia = {
    # Enable modesetting for better compatibility
    modesetting.enable = true;
    open = false;

    # Disable power management features
    powerManagement.enable = false;
    powerManagement.finegrained = false;


    # Enable the NVIDIA settings application
    nvidiaSettings = true;

    # Use the stable version of the NVIDIA driver package
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
