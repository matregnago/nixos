{ config, pkgs, ... }:

{
  imports = [
    ./eza.nix
    ./git.nix
    ./starship.nix
    ./tmux.nix
    ./waybar.nix
    ./nixvim/default.nix
  ];

  home.username = "matheus";
  home.homeDirectory = "/home/matheus";
  home.stateVersion = "25.11";
}
