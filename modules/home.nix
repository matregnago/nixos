{ config, pkgs, ... }:

{
  imports = [
    ./eza.nix
    ./git.nix
    ./starship.nix
    ./tmux.nix
    ./waybar.nix
    ./btop.nix
    ./bat.nix
    ./ssh.nix
    ./kitty.nix
    ./nixvim/default.nix
  ];
  home.packages = with pkgs; [
    vlc
    telegram-desktop
    alacritty
    discord
    obsidian
    zed-editor
    emacs
    pandoc
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
  ];

  programs.home-manager.enable = true;

  home.stateVersion = "26.05";
}
