{ config, lib, pkgs, ... }:

{
  # Webcam module for NixOS
  options.custom.webcam = {
    enable = lib.mkEnableOption "Enable webcam support";
  };

  config = lib.mkIf config.custom.webcam.enable {
    # Load USB webcam kernel module
    boot.kernelModules = [ "uvcvideo" ];

    # Install webcam-related packages
    environment.systemPackages = with pkgs; [
      v4l-utils   # Webcam configuration tools
      cheese      # GNOME webcam testing app
      guvcview    # Another webcam viewer and test tool
    ];

    # Additional security and access configuration
    security.wrappers = {
      # Ensure proper permissions for video devices
      v4l-ctl = {
        source = "${pkgs.v4l-utils}/bin/v4l2-ctl";
        capabilities = "cap_sys_admin+ep";
      };
    };
  };
}
