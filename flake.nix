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
      user = "lpenz";
      urxvtnotify = ./scripts/urxvt-notify;
      mkHomeConfig = system:
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          execpermfix = (import ./mypkgs/execpermfix.nix) { inherit pkgs; };
          fundle = (import ./mypkgs/fundle.nix) { inherit pkgs; };
        in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit user urxvtnotify execpermfix fundle; };
          modules = [
            nixvim.homeModules.nixvim
            ./home.nix
          ];
        };
    in
    {
      homeConfigurations = {
        "lpenz@htpc" = mkHomeConfig "aarch64-linux";
        "lpenz" = mkHomeConfig "x86_64-linux";
      };
    };
}
