{ pkgs }:
pkgs.stdenv.mkDerivation rec {
  pname = "execpermfix";
  version = "1.0.8";
  src = pkgs.fetchFromGitHub {
    owner = "lpenz";
    repo = "execpermfix";
    rev = "v1.0.8";
    sha256 = "0b4ryzikzf9cdjp8igq4czhjhsw2q57yycg39wxkinh78ys1iyjj";
  };
  buildInputs = [ pkgs.cmake ];
  cargoHash = "";
}
