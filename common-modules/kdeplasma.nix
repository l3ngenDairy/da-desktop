{
  services.xserver.enable = true;

  # Enable SDDM for X11
  services.displayManager.sddm.enable = true;

  # Use KDE Plasma 5 (X11 version) instead of Plasma 6
        #services.xserver.desktopManager.plasma5.enable = true;
  services.desktopManager.plasma6.enable = true;      

  # Enable automatic login for the user
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "david";
}
