{ pkgs }:

pkgs.fishPlugins.buildFishPlugin {
  pname = "fundle";
  version = "0-unstable-2022-10-21";

  src = pkgs.fetchFromGitHub {
    owner = "danhper";
    repo = "fundle";
    rev = "f4b39217e135fd209bd4e055eca8d32decdd91e0";
    hash = "sha256-w4DETfOiufpyvwfEAFjDeIo35tphTvbtX7nkUEaB5TQ=";
  };

  meta = {
    description = "A minimalist package manager for fish shell";
    homepage = "https://github.com/danhper/fundle";
    license = pkgs.lib.licenses.mit;
  };
}
