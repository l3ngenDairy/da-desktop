{ pkgs ,config , ... }:{
  environment.systemPackages = with pkgs; [
    transmission_4-gtk             
  ];
  services.transmission.settings = {
    download-dir = "${config.services.transmission.home}/Downloads";
  };
}
