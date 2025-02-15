{
  pkgs,
  config,
  ...
}: let
  username = "kezazel";
  description = "Kezazel";
in {
  users.users.${username} = {
    inherit description;

    shell = pkgs.wrappedPkgs.nushell;
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" ];


    # only declare common packages here
    # others: hosts/<hostname>/user-configuration.nix
    packages = [
      pkgs.btop
      (pkgs.wrappedPkgs.git.override {
        username = description;
        email = "kezazel@daedalus";
      })
    ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICELSL45m4ptWDZwQDi2AUmCgt4n93KsmZtt69fyb0vy rexies@Zaphkiel"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHZTLQQzgCvdaAPdxUkpytDHgwd8K1N1IWtriY4tWSvn rexies@Raphael"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICZvsZTvR5wQedjnuSoz9p7vK7vLxCdfOdRFmbfQ7GUd rexies@Seraphine"
    ];
  };


}
