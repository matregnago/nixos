{ ... }:

{
  programs.ssh = {
    extraConfig = "
        Host pcad
          Hostname gppd-hpc.inf.ufrgs.br
          ForwardAgent no
          User matregnago
      ";
  };
}
