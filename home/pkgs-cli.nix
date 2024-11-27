{pkgs, ...}: {
  home.packages = [
    pkgs.alejandra
    pkgs.tldr
    pkgs.ansible
  ];

  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      dates = "weekly";
    };
    flake = "/home/bas/nix-conf";
  };

  programs.git = {
    enable = true;
    userEmail = "bas@noemail.invalid";
    userName = "bas";
  };

  programs.btop.enable = true;

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.lf = {
    enable = true;
    settings = {hiddenfiles = ".*:!.config";};
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
}
