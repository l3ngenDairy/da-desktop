{ pkgs, ... }: {



    nixpkgs.config = {
      allowUnfree = true;
      permittedInsecurePackaages = ["python-2.7.18.8" "electron-25.9.0" ]; 
    };
    
    environment.systemPackages = with pkgs; [
    usbutils
    pciutils            
    ladybird            
    glances           
    sniffnet
    protonvpn-gui             
    wineWowPackages.stable
    freecad 
    sqlite
    vulkan-tools
    wl-clipboard
    cliphist
    xclip

    # === APPS ===
    # -- browsers --
    firefox
    tor-browser
    # -- fun --
    discord
    # -- office --
    anki
    libreoffice-qt6-fresh
    obsidian
    # -- media --
    gimp
    obs-studio
    spotify
    spotify-player
    vlc
    # -- files --
    bat
    duplicati
    eza
    file
    fzf
    p7zip
    ripgrep
    tree
    unzip
    zoxide
    # -- image --
    feh
    ffmpeg
    flameshot
    # -- system --
    fastfetch
    htop
    kitty
    tmux
    xonsh
    # -- network --
    tcpdump            
    cups
    curl
    openvpn
    tor
    wget
    # === DEVELOPMENT ===
    # -- debugging --
    gdb
    gef
    valgrind
    
    # -- libraries --
    stripe-cli
    gobject-introspection
    # -- c --
    gcc
    clang
    # -- tools --
    git
    exiftool
    # -- python --
    python3
    pipx
    python312Packages.cli-helpers
    python312Packages.netifaces
    python312Packages.pip
    # (python3.withPackages (ps: with ps; [ requests ]))
    # -- man pages --
    linux-manual
    man-pages
    man-pages-posix
    # -- hacking --
    aircrack-ng
    ffuf
    ghidra-bin
    gobuster
    metasploit
    netcat-openbsd
    nmap
    ropgadget
    sqlmap
    thc-hydra
    social-engineer-toolkit
    wireshark
    wordlists
    hashcat

    # -- sdr --
    pkg-config
    rtl-sdr
    rtl-sdr-librtlsdr
    sdrpp

    # === XORG ===
    # -- applications --
    # -- tools --
    xorg.xdpyinfo # info on xserver
    # -- display --
    arandr
    autorandr
    lxappearance
    picom
    xorg.xrandr

    # -- theme --
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    waybar
    wofi
  ];

  fonts.packages = with pkgs; [
    # jetbrains-mono
    noto-fonts
    noto-fonts-emoji
    cascadia-code
    # twemoji-color-font
    font-awesome
    powerline-fonts
    powerline-symbols
    # (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })	
    ];
}


