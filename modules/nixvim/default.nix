{ ... }:

{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
  };
  imports = [
    ./plugins/colorschemes.nix
    ./plugins/telescope.nix

    # LSPs
    ./plugins/lsp.nix
    # Notifications and LSP progress messages
    ./plugins/fidget.nix
    # Diagnostics
    ./plugins/trouble.nix
    # Format
    ./plugins/conform.nix
    # Icons for telescope (just to clear a warning)
    ./plugins/web-devicons.nix
  ];
}
