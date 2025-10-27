{
  lib,
  config,
  ...
}:
let
  cfg = config.myDE.i3;
in
{
  config = lib.mkIf cfg.enable {
    services.pipewire = {
      enable = true;
      pulse.enable = true;
      jack.enable = true;
      alsa.enable = true;
      wireplumber.enable = true;
    };
  };
}
