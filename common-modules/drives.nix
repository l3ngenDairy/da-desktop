{
  services.fstrim.enable = true;

  # Configure additional file systems
  fileSystems = {
    "/media/drive-1" = {
      device = "/dev/sdb1";
      fsType = "ext4";
      options = [ "defaults" "nofail" "users" ];
    };

    "/media/drive-2" = {
      device = "/dev/sda1";
      fsType = "ext4";
      options = [ "defaults" "nofail" "users" ];
    };
  };
}

