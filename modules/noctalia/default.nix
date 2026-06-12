{ ... }:

let
  config = fromTOML (builtins.readFile ./noctalia-config.toml);
in
{
  programs.noctalia = {
    enable = true;
    settings = config;
  };
}
