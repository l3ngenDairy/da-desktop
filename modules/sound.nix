{
        #  services.pulseaudio.enable = false; # sound settings
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    wireplumber.enable = true;

    audio.enable = true;
  };
  environment.variables = {
    PIPEWIRE_LATENCY = "512/48000";  # Balanced latency setting
  }; 
}
