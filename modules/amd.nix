{ config, pkgs, lib, ... }:

{
  # Enable AMD GPU drivers
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true; # Enable 32-bit support if needed
  };

  # Use the latest AMDGPU driver
  services.xserver.videoDrivers = [ "amdgpu" ];

  # Kernel modules for AMD GPU
  boot.initrd.kernelModules = [ "amdgpu" ];

  # Optional: Enable Vulkan support for AMD
  hardware.opengl.extraPackages = with pkgs; [
    amdvlk
  ];

  # Optional: Enable OpenCL support
  hardware.opengl.extraPackages32 = with pkgs; [
    rocm-opencl-icd
    rocm-opencl-runtime
  ];

  # Optional: Enable AMD GPU overclocking and power management
  boot.kernelParams = [
    "amdgpu.ppfeaturemask=0xffffffff" # Enable all power features
  ];

  # Optional: Install tools for monitoring and managing AMD GPUs
  environment.systemPackages = with pkgs; [
    radeontop
    amdgpu_top
  ];
}
