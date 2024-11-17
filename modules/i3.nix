{
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = "Mod4";
      gaps.inner = 10;
      menu = ''"rofi -modi window,run,drun -show drun -show-icons"'';
      terminal = "kitty";
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
}
