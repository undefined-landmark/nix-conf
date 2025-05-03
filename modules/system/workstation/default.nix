{
  lib,
  config,
  ...
}: let
  cfg = config.custom-modules.desktop-environment;
in {
  imports = [
    ./kde.nix
    ./x11.nix
    ./audio.nix
    ./gnome.nix
    ./nvidia.nix
    ./stylix.nix
    ./printing.nix
    ./samba-mount.nix
    ./virt-manager.nix
  ];

  options.custom-modules.desktop-environment = {
    enable = lib.mkEnableOption "Desktop environment";
  };

  config = lib.mkIf cfg.enable {
    nix.extraOptions = ''
      extra-substituters = https://devenv.cachix.org
      extra-trusted-public-keys = devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=
    '';
  };
}
