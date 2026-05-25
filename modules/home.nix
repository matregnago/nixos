{ config, pkgs, ... }:

{
  imports = [
    ./eza.nix
    ./git.nix
    ./starship.nix
    ./tmux.nix
    ./waybar.nix
  ];
  home.packages = with pkgs; [
    vlc
    telegram-desktop
    kitty
    alacritty
    spotify
    discord
    obsidian
    notion
    zed-editor
    emacs
    pandoc
    keepassxc
    cudaPackages.nsight_systems
    claude-code
    jdk25
    lsof
    hugo
    glow
    thunderbird
    pass

    nodejs
    wl-clipboard
    lazygit
    lazydocker
    stremio-linux-shell
    stripe-cli
    github-copilot-cli
    nil
    nixd
    vscode
    gh
    rustup
  ];

  programs.home-manager.enable = true;

  home.stateVersion = "26.05";
}
