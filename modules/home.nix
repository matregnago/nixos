{
  config,
  pkgs,
  inputs,
  ...
}:

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
      keepassxc
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
      unixtools.netstat
      zathura
      busybox
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
      ghostty
      rtk
     rust-bin.stable.latest.complete
    ])
    ++ [
      inputs.claude-code.packages.${pkgs.stdenv.hostPlatform.system}.default
      inputs.helium.packages.${pkgs.stdenv.hostPlatform.system}.default
      inputs.codex.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

  programs.home-manager.enable = true;

  home.stateVersion = "25.11";
}
