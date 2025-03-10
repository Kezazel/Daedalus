{
  pkgs,
  config,
  ...
}: let
  username = "rexies";
  description = "Rexiel Scarlet";
in {
  users.users.${username} = {
    inherit description;

    shell = pkgs.wrappedPkgs.nushell;
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "multimedia"];
    hashedPasswordFile = config.age.secrets.rexiesPass.path;

    # only declare common packages here
    # others: hosts/<hostname>/user-configuration.nix
    packages = [
      pkgs.btop
      (pkgs.wrappedPkgs.git.override {
        username = description;
        email = "37258415+Rexcrazy804@users.noreply.github.com";
      })
    ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICELSL45m4ptWDZwQDi2AUmCgt4n93KsmZtt69fyb0vy rexies@Zaphkiel"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHZTLQQzgCvdaAPdxUkpytDHgwd8K1N1IWtriY4tWSvn rexies@Raphael"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICZvsZTvR5wQedjnuSoz9p7vK7vLxCdfOdRFmbfQ7GUd rexies@Seraphine"
    ];
  };

  # define secrets
  age.secrets.rexiesPass = {
    file = ../secrets/secret1.age;
    owner = username;
  };
}
