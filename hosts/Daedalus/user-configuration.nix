{ pkgs, ... }: let
  generic = [
    pkgs.wineWowPackages.stable
    pkgs.bottles
    pkgs.winetricks
    pkgs.rconc
    pkgs.filelight
    pkgs.plasma-panel-colorizer
    pkgs.heroic
    pkgs.whatsapp-for-linux
    pkgs.cheese
    pkgs.desmume
    pkgs.typora
    pkgs.wpsoffice
    pkgs.gcc
    pkgs.spotify
    pkgs.anki
    pkgs.jetbrains.clion
  ];

  special = builtins.attrValues {
    alacritty = pkgs.wrappedPkgs.alacritty.override {
      extra-config = {
        font.size = 13.0;
      };
    };

    mpv = pkgs.wrappedPkgs.mpv;

    discord = pkgs.discord.override {
      withOpenASAR = true;
      withVencord = true;
    };

    catppucin-kde = pkgs.catppuccin-kde.override {
      flavour = ["mocha"];
      accents = ["pink"];
    };
  };

  # vscode = pkgs.vscode.fhsWithPackages (ps: with ps; [ gdb gcc pkg-config ]);

in {
  users.users."kezazel".packages = special ++ generic;
}
