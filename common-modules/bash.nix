{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.fastfetch ];      
  programs.bash.interactiveShellInit = ''
    fastfetch
  '';
}
