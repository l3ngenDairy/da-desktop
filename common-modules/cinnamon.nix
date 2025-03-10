{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;

    # Enable Cinnamon desktop environment
    desktopManager.cinnamon.enable = true;

    # Enable LightDM as the display manager (optional, can be replaced with GDM)
    displayManager.lightdm.enable = true;

    # Optional: Auto-login configuration
     # Server flags to disable screen blanking, standby, suspend, and off time
    serverFlagsSection = ''
      Option "BlankTime" "0"
      Option "StandbyTime" "0"
      Option "SuspendTime" "0"
      Option "OffTime" "0"
    '';
  };

  # Disable power-profiles-daemon (optional, if you don't want it)
  services.power-profiles-daemon.enable = false;

   services.displayManager.autoLogin = {
      enable = true;
      user = "david";
    };


}
