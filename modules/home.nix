{ config, pkgs, ... }:

{
  imports = [
    ./eza.nix
    ./git.nix
    ./starship.nix
    ./tmux.nix
    ./btop.nix
    ./bat.nix
    ./ssh.nix
    ./kitty.nix
    ./bash.nix
    ./spicetify.nix
    ./nixvim/default.nix
    ./niri/default.nix
    ./noctalia/default.nix
    ./doom-emacs/default.nix
  ];
  home.packages = with pkgs; [
    vlc
    telegram-desktop
    discord
    obsidian
    zed-editor
    keepassxc
    cudaPackages.nsight_systems
    claude-code
    jdk25
    lsof
    thunderbird
    pass
    nodejs
    wl-clipboard
    lazygit
    stremio-linux-shell
    stripe-cli
    github-copilot-cli
    nil
    nixd
    vscode
    gh
    rustup
    unixtools.netstat
    zathura
    busybox
    (prismlauncher.override {
      additionalLibs = [
        jemalloc
        libxtst
        libxkbcommon
        libxt
        libxinerama
      ];
    })
    vscode-json-languageserver
    chromium
    fastfetch
    blender
    xwayland-satellite # xwayland support
    fzf
  ];

  programs.home-manager.enable = true;

  home.stateVersion = "25.11";
}
