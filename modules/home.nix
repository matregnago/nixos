{
  config,
  pkgs,
  inputs,
  ...
}:
let
  system = pkgs.stdenv.hostPlatform.system;
  llm-agents = inputs.llm-agents.packages.${system};
  helium = inputs.helium.packages.${system}.default;
  # codex = inputs.codex.packages.${system}.default;
  in
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
    ./niri/default.nix
    ./noctalia/default.nix
    ./doom-emacs/default.nix
    ./kanshi.nix
    ./theme.nix
    ./yazi.nix
  ];
  home.packages =
    (with pkgs; [
      vlc
      telegram-desktop
      discord
      obsidian
      zed-editor
      lsof
      thunderbird
      nodejs
      wl-clipboard
      lazygit
      stremio-linux-shell
      stripe-cli
      nil
      nixd
      gh
      unixtools.netstat
      zathura
      vscode-json-languageserver
      fastfetch
      xwayland-satellite # xwayland support
      fzf
      fd
      gcc
      pkg-config
      gnupg
      gnumake
      podman-compose
      openssl
      vim
      wget
      ripgrep
      coreutils
      go
      gopls
      clang-tools
      python3
      nixfmt
      rust-bin.stable.latest.complete
    ])
    ++ [
      helium
      llm-agents.claude-code
      llm-agents.codex
      llm-agents.rtk
    ];

  programs.home-manager.enable = true;

  home.stateVersion = "25.11";
}
