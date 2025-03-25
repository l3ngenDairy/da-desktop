{ pkgs, ... }: {
  programs.zsh.enable = true;

  users = {
    defaultUserShell = pkgs.bash;

    users.david = {
      isNormalUser = true;
      description = "david";
      extraGroups = [ "networkmanager" "wheel" "input" "libvirtd" "video"];
      packages = with pkgs; [];
    };
  };

  # Enable automatic login for the user.
   services.getty.autologinUser = "david";
}
