{lib, config, pkgs, ...}: {
  options = {
    packages = {
      sway.enable = lib.mkEnableOption "Enable Sway";
    };
  };

  config = lib.mkIf config.packages.sway.enable {
    services.swayosd = {
      enable = true;
      # stylePath = null;
    };

    home.packages = with pkgs; [
      brightnessctl
      pamixer
    ];

    wayland.windowManager.sway = {
      enable = true;
      systemd.enable = true;
      checkConfig = true;
      config = rec {
        modifier = "Mod4";
        terminal = "alacritty";
        gaps = {
          smartGaps = true;
          smartBorders = "on";
          inner = 10;
          outer = 5;
        };

        window = {
          titlebar = false;
        };

        keybindings = lib.mkOptionDefault {
          # "${modifier}+Return" = "exec ${terminal}";
          "${modifier}+Shift+q" = "kill";
          "${modifier}+Return" = "exec wofi --show drun";
        };

        keycodebindings = {
          # Brightness
        	# "XF86MonBrightnessDown" = "exec brightnessctl set 1%-";
        	# "XF86MonBrightnessUp" = "exec brightnessctl set 1%+";
          # Volume
        	# "XF86AudioRaiseVolume" = "exec 'pamixer -i 5'";
        	# "XF86AudioLowerVolume" = "exec 'pamixer -d 5'";
        	# "XF86AudioMute" = "exec 'pactl set-sink-mute @DEFAULT_SINK@ toggle'";
        };

        input = {
          "type:touchpad" = {
            dwt = "enabled";
            tap = "enabled";
            drag = "enabled";
            scroll_method = "two_finger";
            natural_scroll = "enabled";
            middle_emulation = "enabled";
          };
        };

        fonts = {
          names = ["CaskaydiaMono Nerd font"];
          style = "Regular";
          size = 8.0;
        };

        startup = let 
          wall = ../../dots/__yoru_chainsaw_man_drawn_by_banechiii__b55e78c91ee67398c7222a3a1c4286cc.jpg;
        in [
          {command="${pkgs.swaybg}/bin/swaybg -i ${wall} -m fill";}
          # {command="systemctl --user restart waybar"; always = true;}
        ];

        bars = [];
      };
    };
  };
}
