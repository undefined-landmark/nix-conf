{
  lib,
  config,
  ...
}: let
  cfg = config.myHome.autorandr;
in {
  options.myHome.autorandr = {
    enable = lib.mkEnableOption "autorandr setup";
  };

  config = lib.mkIf cfg.enable {
    services.autorandr.enable = true;
    programs.autorandr = let
      edp1_fp = "00ffffffffffff0009e5320900000000011e0104a51f117803b2a5a657529f27125054000000010101010101010101010101010101013b3880de703828403020360035ae1000001afc2c80de703828403020360035ae1000001a000000fe00424f452043510a202020202020000000fe004e4531343046484d2d4e36310a005b";
      dp3_fp = "00ffffffffffff0009d1358045540000141e0103803c22782a3355ac524ea026105054a56b80d1c0b300a9c08180810081c001010101565e00a0a0a029503020350055502100001a000000ff0046354c30323439363031390a20000000fd00184c1e873c000a202020202020000000fc0042656e5120504432373035510a0189020344f14f5d5e5f6061101f22212004131203012309070783010000e200cf6d030c001000383c20006001020367d85dc401788003e305c301e30f1800e6060501575748565e00a0a0a029503020350055502100001a00000000000000000000000000000000000000000000000000000000000000000000000000000000007c";
    in {
      enable = true;
      profiles = {
        docked-closed = {
          fingerprint.DP-3 = dp3_fp;
          config = {
            eDP-1.enable = false;
            HDMI-1.enable = false;
            DP-1.enable = false;
            DP-2.enable = false;
            DP-4.enable = false;
            DP-3 = {
              enable = true;
              crtc = 0;
              mode = "2560x1440";
              position = "0x0";
              primary = true;
              rate = "59.95";
            };
          };
        };
        docked-open = {
          fingerprint = {
            DP-3 = dp3_fp;
            eDP-1 = edp1_fp;
          };
          config = {
            HDMI-1.enable = false;
            DP-1.enable = false;
            DP-2.enable = false;
            DP-4.enable = false;
            eDP-1 = {
              enable = true;
              crtc = 1;
              mode = "1920x1080";
              position = "0x0";
              rate = "60.00";
            };
            DP-3 = {
              enable = true;
              primary = true;
              crtc = 0;
              mode = "2560x1440";
              position = "1920x0";
              rate = "59.95";
            };
          };
        };
        away = {
          fingerprint.eDP-1 = edp1_fp;
          config = {
            HDMI-1.enable = false;
            DP-1.enable = false;
            DP-2.enable = false;
            DP-3.enable = false;
            DP-4.enable = false;
            eDP-1 = {
              enable = true;
              primary = true;
              crtc = 0;
              mode = "1920x1080";
              position = "0x0";
              rate = "60.00";
            };
          };
        };
      };
    };
  };
}
