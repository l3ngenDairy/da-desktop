{ lib, ... }:
{
  services.fstrim.enable = true;

  # Configure additional file systems
  fileSystems = {
    "/media/drive-1" = {
      device = lib.mkForce "/dev/sdb1";
      fsType = "ext4";
      options = [ "defaults" "nofail" "users" ];
    };

    "/media/drive-2" = {
      device = lib.mkForce "/dev/sda1";
      fsType = "ext4";
      options = [ "defaults" "nofail" "users" ];
    };
  };
}

