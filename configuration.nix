{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/all.nix
      ./user.nix
    ];
  # Install firefox.
  programs.firefox.enable = true;
  custom.webcam.enable = true;      

  hardware.enableAllFirmware = true;
  system.stateVersion = "24.11";
  networking.hostName = "da-desktop";
}
