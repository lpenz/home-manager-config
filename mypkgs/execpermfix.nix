{ pkgs }:
pkgs.stdenv.mkDerivation rec {
  pname = "execpermfix";
  version = "1.0.11";
  src = pkgs.fetchFromGitHub {
    owner = "lpenz";
    repo = "execpermfix";
    rev = "v1.0.11";
    sha256 = "sha256-Kwhqf1mwte6x3T9mhRZG0BekQOq0D1ycWNvpTzcdroY=";
  };
  buildInputs = [ pkgs.cmake ];
  cargoHash = "";
}
