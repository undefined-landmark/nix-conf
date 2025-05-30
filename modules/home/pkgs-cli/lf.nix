{
  lib,
  config,
  ...
}: let
  cfg = config.myHome.pkgs-cli;
in {
  config = lib.mkIf cfg.enable {
    programs.lf = {
      enable = true;
      settings = {
        hiddenfiles = ".*:!.config";
        shell = "bash";
        shellopts = "-eu";
      };
      keybindings = {
        "<enter>" = "shell";
        a = ":push %mkdir<space>";
        "`" = "!true";
        gm = "cd /mnt/";
        gu = "cd /run/media/bas/";
      };
      commands = {
        z = ''
          %{{
          result="$(zoxide query --exclude "$PWD" "$@" | sed 's/\\/\\\\/g;s/"/\\"/g')"
          lf -remote "send $id cd \"$result\""
          }}
        '';
        zi = ''
          ''${{
          result="$(zoxide query -i | sed 's/\\/\\\\/g;s/"/\\"/g')"
          lf -remote "send $id cd \"$result\""
          }}
        '';
        on-cd = ''
          &{{
          zoxide add "$PWD"
          }}
        '';
      };
    };
  };
}
