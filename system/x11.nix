{
  services.xserver = {
    enable = true;
    windowManager.i3.enable = true;
    displayManager.lightdm.greeters.mini = {
      enable = true;
      user = "bas";
    };
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  services.picom.enable = true;
}
