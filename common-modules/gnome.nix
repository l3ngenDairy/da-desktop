{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;

    # Enable GNOME desktop environment
    desktopManager.gnome.enable = true;

    # Enable GDM (GNOME Display Manager)
    displayManager.gdm.enable = true;

    # Optional: Auto-login configuration
    displayManager.autoLogin = {
      enable = true;
      user = "david";
    };

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

  # GNOME settings overrides to disable screensaver and idle activation
  services.xserver.desktopManager.gnome.extraGSettingsOverrides = ''
    [org.gnome.desktop.screensaver]
    lock-enabled=false
    idle-activation-enabled=false

    [org.gnome.desktop.session]
    idle-delay=0
  '';
}
