{
  lib,
  config,
  ...
}: let
  cfg = config.custom-modules.audio;
in {
  options.custom-modules.audio = {
    enable = lib.mkEnableOption "Audio setting";
  };

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
