{ ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Matheus Tregnago";
        email = "maugustotreg@gmail.com";
      };
      init.defaultBranch = "main";
    };
  };
}
