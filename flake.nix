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
      urxvtnotify = ./scripts/urxvt-notify;
      pkgs = nixpkgs.legacyPackages.${system};
      mypkgs = {
        execpermfix = execpermfix.packages.${system}.default;
        ogle = ogle.packages.${system}.default;
        tuzue = tuzue.packages.${system}.default;
      };
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
              mypkgs.execpermfix
              mypkgs.tuzue
              mypkgs.ogle

              pkgs.autoflake
              pkgs.bat
              pkgs.black
              pkgs.direnv
              pkgs.fd
              pkgs.fzf
              pkgs.glibcLocales
              pkgs.htop
              pkgs.nnn
              pkgs.ripgrep
              pkgs.shellcheck
              pkgs.shfmt
              pkgs.topgrade
              pkgs.zsh
            ];

            programs.emacs.enable = true;

            # Fish
            programs.fish = (import ./fish.nix) {
              inherit pkgs urxvtnotify;
            };

            # Install executables in ~/bin
            home.file = {
              # nix's own
              "bin/home-manager".source = "${pkgs.home-manager}/bin/home-manager";
              "bin/nix" = {
                executable = true;
                text = ''
                         #!/bin/bash
                         PATH="$HOME/.nix-profile/bin:$PATH"
                         exec ${pkgs.nix}/bin/nix "$@"
                       '';
              };
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
              "bin/execpermfix".source = "${mypkgs.execpermfix}/bin/execpermfix";
              "bin/tuzue-chdir".source = "${mypkgs.tuzue}/bin/tuzue-chdir";
              "bin/tuzue-json".source = "${mypkgs.tuzue}/bin/tuzue-json";
              "bin/tuzue-manmenu".source = "${mypkgs.tuzue}/bin/tuzue-manmenu";
              "bin/ogle".source = "${mypkgs.ogle}/bin/ogle";
              # local scripts
              "bin/cleantop" = { executable = true; source = ./scripts/cleantop; };
              "bin/tmux-pstree" = { executable = true; source = ./scripts/tmux-pstree; };
              "bin/urxvt-notify" = { executable = true; source = "${urxvtnotify}"; };
              # regular packages
              "bin/autoflake".source = "${pkgs.autoflake}/bin/autoflake";
              "bin/bat".source = "${pkgs.bat}/bin/bat";
              "bin/black".source = "${pkgs.black}/bin/black";
              "bin/direnv".source = "${pkgs.direnv}/bin/direnv";
              "bin/fd".source = "${pkgs.fd}/bin/fd";
              "bin/fish".source = "${pkgs.fish}/bin/fish";
              "bin/fzf".source = "${pkgs.fzf}/bin/fzf";
              "bin/htop".source = "${pkgs.htop}/bin/htop";
              "bin/nnn" = {
                executable = true;
                text = ''
                         #!/bin/bash
                         export PAGER=less
                         exec "${pkgs.nnn}/bin/nnn" "$@"
                       '';
              };
              "bin/rg".source = "${pkgs.ripgrep}/bin/rg";
              "bin/shellcheck".source = "${pkgs.ripgrep}/bin/shellcheck";
              "bin/shfmt".source = "${pkgs.shfmt}/bin/shfmt";
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
