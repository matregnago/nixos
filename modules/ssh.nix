{ ... }:

{
  programs.ssh = {
    enable = true;
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
