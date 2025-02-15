{pkgs, ...}: {
  users.users."kezazel".packages = builtins.attrValues {
    alacritty = pkgs.wrappedPkgs.alacritty.override {
      extra-config = {
        font.size = 13.0;
      };
    };

    mpv = pkgs.wrappedPkgs.mpv;



    inherit (pkgs.wineWowPackages) stable;
    inherit
      (pkgs)
      bottles
      winetricks
      rconc
      filelight
      discord
      heroic
      ryujinx
      ;


  };
}
