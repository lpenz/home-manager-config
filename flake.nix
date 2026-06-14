{
  description = "lpenz's home-manager config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    cachix.url = "github:cachix/cachix";
    nixvim = {
      url = "github:nix-community/nixvim/nixos-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, cachix, nixvim, ... }:
    let
      system = "x86_64-linux";
      user = "lpenz";
      urxvtnotify = ./scripts/urxvt-notify;
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      execpermfix = (import ./mypkgs/execpermfix.nix) { inherit pkgs; };
    in
    {
      homeConfigurations.lpenz = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit user urxvtnotify execpermfix; };
        modules = [
          nixvim.homeModules.nixvim
          ./home.nix
        ];
      };
    };
}
