{ pkgs, inputs, ... }:
let
  mcsrPkgs = inputs.mcsr.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  imports = [ inputs.mcsr.nixosModules.waywall ];

    environment.systemPackages = [
      mcsrPkgs.ninjabrain-bot
      (pkgs.prismlauncher.override {
        jdks = [ pkgs.jdk8 ];
      })
    ];

    programs.waywall = {
      enable = true;
      config = {
        enableWaywork = true;
        programs = [ mcsrPkgs.ninjabrain-bot ];
        files = {
          eye_overlay = ./eye-overlay.png;
          thin = ./thin.png;
          wide = ./wide.png;
          tall = ./tall.png;
        };

        text = ''
          local resolution = { w = 1920, h = 1080 }
        ''
        + builtins.readFile ./waywall.lua;
      };
    };
}
