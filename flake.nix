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
              pkgs.clang-tools
              pkgs.direnv
              pkgs.fd
              pkgs.fzf
              pkgs.glibcLocales
              pkgs.global
              pkgs.htop
              pkgs.nnn
              pkgs.renameutils
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
              # clang
              "bin/clang-apply-replacements".source = "${pkgs.clang-tools}/bin/clang-apply-replacements";
              "bin/clang-change-namespace".source = "${pkgs.clang-tools}/bin/clang-change-namespace";
              "bin/clang-check".source = "${pkgs.clang-tools}/bin/clang-check";
              "bin/clangd".source = "${pkgs.clang-tools}/bin/clangd";
              "bin/clang-doc".source = "${pkgs.clang-tools}/bin/clang-doc";
              "bin/clang-extdef-mapping".source = "${pkgs.clang-tools}/bin/clang-extdef-mapping";
              "bin/clang-format".source = "${pkgs.clang-tools}/bin/clang-format";
              "bin/clang-include-fixer".source = "${pkgs.clang-tools}/bin/clang-include-fixer";
              "bin/clang-linker-wrapper".source = "${pkgs.clang-tools}/bin/clang-linker-wrapper";
              "bin/clang-move".source = "${pkgs.clang-tools}/bin/clang-move";
              "bin/clang-nvlink-wrapper".source = "${pkgs.clang-tools}/bin/clang-nvlink-wrapper";
              "bin/clang-offload-bundler".source = "${pkgs.clang-tools}/bin/clang-offload-bundler";
              "bin/clang-offload-wrapper".source = "${pkgs.clang-tools}/bin/clang-offload-wrapper";
              "bin/clang-query".source = "${pkgs.clang-tools}/bin/clang-query";
              "bin/clang-refactor".source = "${pkgs.clang-tools}/bin/clang-refactor";
              "bin/clang-rename".source = "${pkgs.clang-tools}/bin/clang-rename";
              "bin/clang-reorder-fields".source = "${pkgs.clang-tools}/bin/clang-reorder-fields";
              "bin/clang-repl".source = "${pkgs.clang-tools}/bin/clang-repl";
              "bin/clang-scan-deps".source = "${pkgs.clang-tools}/bin/clang-scan-deps";
              "bin/clang-tidy".source = "${pkgs.clang-tools}/bin/clang-tidy";
              # mine
              "bin/execpermfix".source = "${mypkgs.execpermfix}/bin/execpermfix";
              "bin/tuzue-chdir".source = "${mypkgs.tuzue}/bin/tuzue-chdir";
              "bin/tuzue-json".source = "${mypkgs.tuzue}/bin/tuzue-json";
              "bin/tuzue-manmenu".source = "${mypkgs.tuzue}/bin/tuzue-manmenu";
              "bin/ogle".source = "${mypkgs.ogle}/bin/ogle";
              # local scripts
              "bin/cleantop" = { executable = true; source = ./scripts/cleantop; };
              "bin/ssh-tmux" = { executable = true; source = ./scripts/ssh-tmux; };
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
              "bin/global".source = "${pkgs.global}/bin/global";
              "bin/globash".source = "${pkgs.global}/bin/globash";
              "bin/gozilla".source = "${pkgs.global}/bin/gozilla";
              "bin/gtags-cscope".source = "${pkgs.global}/bin/gtags-cscope";
              "bin/gtags".source = "${pkgs.global}/bin/gtags";
              "bin/htags-server".source = "${pkgs.global}/bin/htags-server";
              "bin/htags".source = "${pkgs.global}/bin/htags";
              "bin/htop".source = "${pkgs.htop}/bin/htop";
              "bin/nnn" = {
                executable = true;
                text = ''
                         #!/bin/bash
                         export PAGER=less
                         exec "${pkgs.nnn}/bin/nnn" "$@"
                       '';
              };
              "bin/qmv".source = "${pkgs.renameutils}/bin/qmv";
              "bin/qcp".source = "${pkgs.renameutils}/bin/qcp";
              "bin/rg".source = "${pkgs.ripgrep}/bin/rg";
              "bin/shellcheck".source = "${pkgs.shellcheck}/bin/shellcheck";
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
