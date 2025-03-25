{ config, lib, pkgs, ... }:

{
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

    # Ensure proper group access for video devices
    users.groups.video = {};
  };
}
