{
  description = "lpenz's home-manager config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    execpermfix.url = "github:lpenz/execpermfix";
    tuzue.url = "github:lpenz/tuzue";
    ogle.url = "github:lpenz/ogle";
  };

  outputs = { nixpkgs, home-manager, execpermfix, tuzue, ogle, ... }:
    let
      system = "x86_64-linux";
      user = "lpenz";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations.lpenz = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          {
            programs.home-manager.enable = true;
            home.stateVersion = "22.11";
            home.username = "${user}";
            home.homeDirectory = "/home/${user}";

            home.packages = [
              execpermfix.packages.${system}.default
              tuzue.packages.${system}.default
              ogle.packages.${system}.default

              pkgs.direnv
              pkgs.fd
              pkgs.fzf
              pkgs.glibcLocales
              pkgs.nnn
              pkgs.ripgrep
              pkgs.topgrade
              pkgs.zsh
            ];

            programs.emacs.enable = true;
          }
        ];
      };
    };
}
