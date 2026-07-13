{ ... }:
{
  programs.doom-emacs = {
    enable = true;
    doomDir = ./doom.d;
    extraPackages = epkgs: [
      epkgs.treesit-grammars.with-all-grammars
      epkgs.org-ref
    ];
  };
}
