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
    ./nixvim/default.nix
    ./niri/default.nix
    ./noctalia/default.nix
    ./doom-emacs/default.nix
    ./kanshi.nix
  ];
  home.packages =
    (with pkgs; [
      vlc
      telegram-desktop
      discord
      obsidian
      zed-editor
      keepassxc
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
      vscode-json-languageserver
      chromium
      fastfetch
      blender
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
    ])
    ++ [
      inputs.claude-code.packages.${pkgs.stdenv.hostPlatform.system}.default
      inputs.opencode.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

  programs.home-manager.enable = true;

  home.stateVersion = "25.11";
}
