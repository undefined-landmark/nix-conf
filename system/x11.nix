{
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    windowManager.i3.enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  services.displayManager = {
    defaultSession = "none+i3";
  };

  programs.xfconf.enable = true;

  services.libinput = {
    touchpad.naturalScrolling = true;
    mouse.naturalScrolling = true;
  };
}
