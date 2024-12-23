{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.custom-home-modules.i3;
in {
  options.custom-home-modules.i3 = {
    enable = lib.mkEnableOption "i3 setup";
  };

  config = lib.mkIf cfg.enable {
    xsession = {
      enable = true;
      windowManager.i3 = {
        enable = true;
        config = {
          modifier = "Mod4";
          gaps.inner = 10;
          menu = ''"rofi -modi window,run,drun -show drun -show-icons"'';
          terminal = "kitty";
          defaultWorkspace = "workspace number 1";
          bars = [
            (
              config.lib.stylix.i3.bar
              // {
                position = "top";
                trayPadding = 5;
                statusCommand = "i3status-rs config-top.toml";
                fonts = {
                  names = [config.stylix.fonts.monospace.name];
                  size = config.stylix.fonts.sizes.desktop * 1.0;
                };
              }
            )
          ];
          keybindings = let
            modifier = config.xsession.windowManager.i3.config.modifier;
          in
            lib.mkOptionDefault {
              "${modifier}+q" = "kill";
              "${modifier}+h" = "focus left";
              "${modifier}+j" = "focus down";
              "${modifier}+k" = "focus up";
              "${modifier}+l" = "focus right";
              XF86AudioRaiseVolume = "exec pactl set-sink-volume @DEFAULT_SINK@ +10%";
              XF86AudioLowerVolume = "exec pactl set-sink-volume @DEFAULT_SINK@ -10%";
              XF86AudioMute = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
              XF86AudioMicMute = "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle";
              XF86AudioPlay = "exec playerctl play-pause";
              XF86AudioPause = "exec playerctl play-pause";
              XF86MonBrightnessDown = "exec brightnessctl set 5%-";
              XF86MonBrightnessUp = "exec brightnessctl set 5%+";
            };
          startup = [
            {
              command = "xfce4-power-manager";
              always = false;
            }
          ];
        };
      };
    };

    programs.i3status-rust = {
      enable = true;
      bars = {
        top = {
          settings.theme.overrides = config.lib.stylix.i3status-rust.bar;
          blocks = [
            {
              block = "cpu";
              format = " CPU: $utilization.eng(w:1) ";
              merge_with_next = true;
            }
            {
              block = "temperature";
              format = " $average ";
              chip = "*-isa-*";
            }
            {
              block = "memory";
              format = " RAM: $mem_used_percents.eng(w:2) ";
            }
            {
              block = "disk_space";
              path = "/";
              info_type = "used";
              interval = 20;
              warning = 80.0;
              alert = 90.0;
              format = " /: $percentage.eng(w:1) ";
            }
            {
              block = "time";
              interval = 5;
              format = " $timestamp.datetime(f:'%a %b %e %Y') ";
            }
            {
              block = "time";
              interval = 5;
              format = " $timestamp.datetime(f:'%R') ";
            }
          ];
        };
      };
    };

    services.playerctld.enable = true;

    home.packages = [
      pkgs.pulseaudio # for pactl
      pkgs.brightnessctl
      pkgs.playerctl
    ];

    programs.rofi.enable = true;

    programs.kitty = {
      enable = true;
      keybindings = {
        "kitty_mod+enter" = "launch --cwd=current --type=window";
        "kitty_mod+t" = "launch --cwd=current --type=tab";
      };
      settings = {
        "cursor_stop_blinking_after" = 0;
      };
    };

    services.picom = {
      enable = true;
      vSync = true;
    };

    services.dunst = {
      enable = true;
      settings = {
        global = {
          width = "(0, 1000)";
          mouse_left_click = "do_action";
          mouse_middle_click = "close_current";
          mouse_right_click = "context";
        };
      };
    };
  };
}
