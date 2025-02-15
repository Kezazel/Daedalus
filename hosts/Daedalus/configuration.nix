{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./user-configuration.nix
  ];

  networking.hostName = "Daedalus";
  time.timeZone = "Asia/Kolkata";

  graphicsModule = {
    intel.enable = true;
  };

  servModule = {
    enable = true;
    tailscale = {
      enable = true;
      exitNode.enable = false;
      exitNode.networkDevice = "wlp1s0";
    };
    openssh.enable = true;
    jellyfin.enable = false;
    minecraft.enable = false;
  };

  progModule = {
    sddm-custom-theme = {
      enable = true;
     # wallpaper = config.age.secrets.wallpaper.path;
    };
    # anime-games.enable = true;
  };

  # forward dns onto the tailnet
  networking.firewall.allowedTCPPorts = [53];
  networking.firewall.allowedUDPPorts = [53];
  services.dnscrypt-proxy2.settings = {
    listen_addresses = [
     # "100.112.116.17:53"
    #  "[fd7a:115c:a1e0::eb01:7412]:53"
      "127.0.0.1:53"
      "[::1]:53"
    ];
  };


  # generic
  programs = {
    partition-manager.enable = true;
    kdeconnect.enable = true;
  };
  programs.adb.enable = true;
  users.users.kezazel.extraGroups = ["adbusers" "kvm"];
 # services.displayManager.autoLogin.user = "rexies";

  # KDE
  services.desktopManager.plasma6.enable = true;
  services.fstrim.enable = true;

  # disabled autosuspend
 # services.logind.lidSwitchExternalPower = "ignore";

  # minecraft server
  #services.minecraft-servers.servers.hollyj.serverProperties.max-players = lib.mkForce 8;

  # Resolves wifi connectivity issues on Seraphine
  #boot.extraModprobeConfig = lib.concatStringsSep "\n" [
  #  "options iwlwifi 11n_disable=1"
 # ];

  system.stateVersion = "24.11";

  # maybe move this into its own module idk
  environment.systemPackages = [pkgs.firefoxpwa];
  programs.firefox = {
    enable = true;
    nativeMessagingHosts.packages = [
      pkgs.firefoxpwa
    ];
  };
}
