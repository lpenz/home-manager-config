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
              pkgs.direnv
              pkgs.fd
              pkgs.fzf
              pkgs.glibcLocales
              pkgs.htop
              pkgs.nnn
              pkgs.ripgrep
              pkgs.topgrade
              pkgs.zsh

              # fish:
              pkgs.fishPlugins.fzf-fish
              pkgs.fishPlugins.sponge
              pkgs.fishPlugins.tide
            ];

            programs.emacs.enable = true;

            # Fish
            programs.fish = {
              enable = true;
              interactiveShellInit = ''
                # Commands to run in interactive sessions can go here
                set fish_greeting
                set -gx EDITOR vim
                set -gx VISUAL vim
                fzf_configure_bindings
                direnv hook fish | source
                function push-line
                    commandline -f kill-whole-line
                    function restore_line --on-event fish_prompt
                        commandline -f yank
                        functions -e restore_line
                    end
                end
                bind \eq push-line
                bind \ed kill-bigword
                bind \e\x7f backward-kill-bigword
                bind \eb backward-bigword
              '';
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
              # regular packages
              "bin/autoflake".source = "${pkgs.autoflake}/bin/autoflake";
              "bin/bat".source = "${pkgs.bat}/bin/bat";
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
