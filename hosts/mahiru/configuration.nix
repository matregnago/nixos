{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./securo.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "mahiru";

  networking = {
    useDHCP = false;
    interfaces.eno2 = {
      ipv4.addresses = [
        {
          address = "192.168.1.38";
          prefixLength = 24;
        }
      ];
    };
    defaultGateway = {
      address = "192.168.1.1";
      interface = "eno2";
    };
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 ];
    };
    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
    ];
  };

  time.timeZone = "America/Sao_Paulo";

  users.users.matheus = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGnANeIWYTbQSqZ3F+n2OvP+SLDn3gmXhGKeGVP1c60C"
    ];
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    openssl
    git
  ];

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  services.caddy = {
    enable = true;
    package = pkgs.frankenphp.override {
      php = config.services.pterodactyl.panel.phpPackage;
    };
    virtualHosts = {
      ":6769".extraConfig = ''
        root * ${config.services.pterodactyl.panel.package}/public
        php_server
      '';
    };
  };

  # Secrets ficam fora do repo, em /var/lib/secrets na propria maquina.
  # Os caminhos precisam ser strings (entre aspas) para nao irem pro /nix/store.
  services.pterodactyl.panel = {
    enable = true;
    enableNginx = false;
    app = {
      keyFile = "/var/lib/secrets/pterodactyl/app.key";
      url = "https://painel.matregnago.com";
    };
    hashids.saltFile = "/var/lib/secrets/pterodactyl/hashids";
    user = "caddy";
    group = "caddy";
    # Banco local autentica via unix socket como o usuario caddy, sem senha
    database.user = "caddy";
  };

  services.pterodactyl.wings = {
    enable = true;
    openFirewall = true;
    settings = {
      uuid = "5da60e9f-cfa9-400a-b578-49c2ae5af176";
      remote = "https://painel.matregnago.com";
    };
    secrets = {
      tokenIdFile = "/var/lib/secrets/wings/token_id";
      tokenFile = "/var/lib/secrets/wings/token";
    };
  };

  virtualisation.docker.enable = true;
  programs.bash = {
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos-config#mahiru";
    };
  };
  services.cloudflared = {
    enable = true;
    tunnels = {
      "fcb4cc63-6176-40ac-92ae-67e89d97146f" = {
        credentialsFile = "/var/lib/secrets/cloudflared/fcb4cc63-6176-40ac-92ae-67e89d97146f.json";
        default = "http_status:404";
        ingress = {
          "painel.matregnago.com" = "http://localhost:6769";
          "node.matregnago.com" = "http://localhost:8080";
        };
      };
    };
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "26.05";
}
