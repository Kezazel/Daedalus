{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./steam.nix
    ./sddm.nix
    ./aagl.nix
    ./age.nix
  ];

  # global
  environment.systemPackages = builtins.attrValues {
    inherit (pkgs) git wl-clipboard ripgrep p7zip unrar fd;
    nixvim = inputs.nixvim.packages.${pkgs.system}.default;
  };

  # wayland on electron and chromium based apps
  # disabled due to insanely slow startup time
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # direnv enabled by default force this of if required

  programs.direnv = {
    enable = true;
    silent = true;
    loadInNixShell = true;
    nix-direnv.enable = true;
    # this shit isn't working kill me
    direnvrcExtra = ''
      : "''${XDG_CACHE_HOME:="''${HOME}/.cache"}"
      declare -A direnv_layout_dirs
      direnv_layout_dir() {
          local hash path
          echo "''${direnv_layout_dirs[$PWD]:=$(
              hash="$(sha1sum - <<< "$PWD" | head -c40)"
              path="''${PWD//[^a-zA-Z0-9]/-}"
              echo "''${XDG_CACHE_HOME}/direnv/layouts/''${hash}''${path}"
          )}"
      }
    '';
  };
}
