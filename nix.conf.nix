{
  substituters = [ "https://cache.nixos.org" "https://www.lpenz.org/nixpkgs-lpenz/cache" "https://nix-community.cachix.org" "https://lpenz.cachix.org" ];
  trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" "lpenz.org:jYDkTN/2qS96NxFnJpuWkNdVfNaWzaA5pmcg4MyXa2g=" "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" "lpenz.cachix.org-1:ZRfvZ7o/oNiBcD9EtGKpzZSgJKG89uFZn/36zbCh1Oo=" ];
  experimental-features = [ "nix-command" "flakes" ];
  allow-symlinked-store = true;
  use-sqlite-wal = false;
  cores = 1;
  max-substitution-jobs = 1;
  fsync-metadata = false;
}
