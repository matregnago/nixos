{ pkgs, ... }:
{
  gtk = {
    enable = true;
    colorScheme = "dark";
    theme = {
      name = "Nordic";
      package = pkgs.nordic;
    };
    gtk4.theme = {
      name = "Nordic";
      package = pkgs.nordic;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style.name = "kvantum";
    kvantum = {
      enable = true;
      themes = [ pkgs.nordic ];
      settings.General.theme = "Nordic";
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Nordic";
    };
  };
}
