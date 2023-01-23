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

            # Install executables in ~/bin
            home.file = {
              # nix's own
              "bin/home-manager".source = "${pkgs.home-manager}/bin/home-manager";
              "bin/nix".source = "${pkgs.nix}/bin/nix";
              "bin/nix-build".source = "${pkgs.nix}/bin/nix-build";
              "bin/nix-channel".source = "${pkgs.nix}/bin/nix-channel";
              "bin/nix-collect-garbage".source = "${pkgs.nix}/bin/nix-collect-garbage";
              "bin/nix-copy-closure".source = "${pkgs.nix}/bin/nix-copy-closure";
              "bin/nix-daemon".source = "${pkgs.nix}/bin/nix-daemon";
              "bin/nix-env".source = "${pkgs.nix}/bin/nix-env";
              "bin/nix-hash".source = "${pkgs.nix}/bin/nix-hash";
              "bin/nix-instantiate".source = "${pkgs.nix}/bin/nix-instantiate";
              "bin/nix-prefetch-url".source = "${pkgs.nix}/bin/nix-prefetch-url";
              "bin/nix-shell".source = "${pkgs.nix}/bin/nix-shell";
              "bin/nix-store".source = "${pkgs.nix}/bin/nix-store";
              # mine
              "bin/execpermfix".source = "${execpermfix}/bin/execpermfix";
              "bin/tuzue-chdir".source = "${tuzue}/bin/tuzue-chdir";
              "bin/tuzue-json".source = "${tuzue}/bin/tuzue-json";
              "bin/tuzue-manmenu".source = "${tuzue}/bin/tuzue-manmenu";
              "bin/ogle".source = "${ogle}/bin/ogle";
              # regular packages
              "bin/direnv".source = "${pkgs.direnv}/bin/direnv";
              "bin/fd".source = "${pkgs.fd}/bin/fd";
              "bin/fzf".source = "${pkgs.fzf}/bin/fzf";
              # "bin/nnn".source = "${pkgs.nnn}/bin/nnn"; # wrapped
              "bin/rg".source = "${pkgs.ripgrep}/bin/rg";
              "bin/topgrade".source = "${pkgs.topgrade}/bin/topgrade";
              "bin/zsh".source = "${pkgs.zsh}/bin/zsh";
              # emacs
              "bin/emacs".source = "${pkgs.emacs}/bin/emacs";
              "bin/emacsclient".source = "${pkgs.emacs}/bin/emacsclient";
            };
          }
        ];
      };
    };
}
