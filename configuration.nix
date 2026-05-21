{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "nodev" ];
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;

  hardware.bluetooth.enable = true;
  networking.hostName = "nixos";
  networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  networking.nameservers = [
    "1.1.1.1"
    "8.8.8.8"
  ];

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keyboard layout
  console.keyMap = "br-abnt2";
  services.xserver.xkb = {
    layout = "br";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.matheus = {
    isNormalUser = true;
    description = "matheus";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
  };

  programs.nix-ld.enable = true;

  # Install firefox.
  programs.firefox.enable = true;

  # Install niri
  programs.niri.enable = true;

  programs.river-classic.enable = true;

  programs.direnv.enable = true;
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vlc
    vim
    pnpm
    rust-analyzer
    wget
    kitty
    alacritty
    spotify
    discord
    obsidian
    notion
    zed-editor
    emacs
    ripgrep
    coreutils
    fd
    clang
    rustup
    nodejs
    gcc
    pkg-config
    (python3.withPackages (ps: [ ps.pip ]))
    gnupg
    pass
    wl-clipboard
    rust-analyzer
    lazygit
    lazydocker
    stremio-linux-shell
    stripe-cli
    github-copilot-cli
    gnumake
    nil
    nixd
    vscode
    gh
    btop
    fuzzel
    mako
    swaylock
    # External flake packages
    inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
    inputs.prismlauncher.packages.${pkgs.stdenv.hostPlatform.system}.prismlauncher

    nerd-fonts.jetbrains-mono

    lsof
    hugo
    glow
    thunderbird
    postgresql_17
    postgresql_17.lib
    libpq
    docker
    shellcheck
    pandoc
    keepassxc
    cudaPackages.nsight_systems
    claude-code
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    nerd-fonts.symbols-only
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    symbola
  ];

  virtualisation.docker = {
    enable = true;
  };

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_17;
  };

  environment.variables = {
    PKG_CONFIG_PATH = "${pkgs.postgresql_17}/lib/pkgconfig";
    LIBRARY_PATH = "${pkgs.postgresql_17.lib}/lib";
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
    enableSSHSupport = true;
  };

  system.stateVersion = "25.05";

}
