{ ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings."*" = {
      ForwardAgent = false;
      AddKeysToAgent = "no";
      Compression = false;
      ServerAliveInterval = 0;
      ServerAliveCountMax = 3;
      HashKnownHosts = false;
      UserKnownHostsFile = "~/.ssh/known_hosts";
      ControlMaster = "no";
      ControlPath = "~/.ssh/master-%r@%n:%p";
      ControlPersist = "no";
    };
    extraConfig = ''
        Host pcad
          Hostname gppd-hpc.inf.ufrgs.br
          ForwardAgent no
          User matregnago

        Host g5k
          Hostname access.grid5000.fr
          ForwardAgent no
          User mtregnag

        Host *.g5k
          ProxyCommand ssh g5k -W "$(basename %h .g5k):%p"
          ForwardAgent no
          User mtregnag
      '';
  };
}
