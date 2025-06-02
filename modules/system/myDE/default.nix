{
  lib,
  config,
  ...
}: let
  cfg = config.myDE.i3;
in {
  imports = [
    ./audio.nix
    ./gnome.nix
    ./kde.nix
    ./printing.nix
    ./samba-mount.nix
    ./x11.nix
  ];

  options.myDE.i3 = {
    enable = lib.mkEnableOption "Desktop environment";
  };

  config = lib.mkIf cfg.enable {
    nix.extraOptions = ''
      extra-substituters = https://devenv.cachix.org
      extra-trusted-public-keys = devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=
    '';
  };
}
