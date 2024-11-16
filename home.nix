{ config, pkgs, inputs, ... }:

{
  imports = [ inputs.nixvim.homeManagerModules.nixvim ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "bas";
  home.homeDirectory = "/home/bas";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  nixpkgs.config.allowUnfree = true;

  home.packages = [
    pkgs.alejandra
    pkgs.zoom-us
    pkgs.spotify
    pkgs.vmware-horizon-client
    pkgs.fira-code-nerdfont
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/bas/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3;
    config = {
      modifier = "Mod4";
      gaps.inner = 10;
      menu = ''"rofi -modi window,run,drun -show drun -show-icons"'';
      terminal = "kitty";
      fonts = {
        names = [ "FiraCode Nerd Font" ];
        size = 14.0;
      };
      bars = [
        {
          position = "top";
          trayPadding = 5;
          statusCommand = "i3status-rs config-top.toml";
        }
      ];
    };
  };

  programs.i3status-rust = {
    enable = true;
    bars = {
      top = {
        theme = "native";
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

  programs.rofi = {
    enable = true;
  };

  programs.firefox = {
    enable = true;
  };

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    vimdiffAlias = true;
    plugins = {
      lsp = {
        enable = true;
	servers = {
	  nixd = {
	    enable = true;
	    settings = {
	      nixpkgs.expr = "import nixpkgs { }";
	      formatting.command = [ "alejandra" ];
	    };
	  };
        };
      };
    };
  };
}
