{ ... }:

{
  programs.bash = {
    enable = true;
    sessionVariables = {
      PG_LIB_DIR = "/run/current-system/sw/lib";
      PG_INCLUDE_DIR = "/run/current-system/sw/include";
      PKG_CONFIG_PATH = "/run/current-system/sw/lib/pkgconfig";
    };
    bashrcExtra = ''
      eval "$(starship init bash)"
      eval "$(direnv hook bash)"
      [ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"
      export PATH="$HOME/.local/bin:$PATH"
    '';
  };
}
