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
      whatsapp-for-linux
      cheese
      desmume
      typora
      wpsoffice
      jetbrains.clion
      ;

      vscode = pkgs.vscode.fhsWithPackages (ps: with ps; [ gdb gcc pkg-config ]);

  };
}
