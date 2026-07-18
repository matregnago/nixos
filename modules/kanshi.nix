{ ... }: {
  services.kanshi = {
    enable = true;
    settings = [
      {
        profile = {
          name = "home";
          outputs = [
            {
              criteria = "Dell Inc. AW2525HM 5D9X484";
              mode = "1920x1080@240.000";
              position = "1920,0";
            }
            {
              criteria = "PNP(BNQ) ZOWIE XL LCD 24J01873SL0";
              mode = "1920x1080@144.001";
              position = "0,0";
            }
          ];
        };
      }
      {
        profile = {
          name = "undocked";
          outputs = [
            {
              criteria = "eDP-1";
              status = "enable";
            }
          ];
        };
      }
    ];
  };
}
