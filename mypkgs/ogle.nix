{ pkgs }:
pkgs.rustPlatform.buildRustPackage rec {
  pname = "ogle";
  version = "2.0.2";
  src = pkgs.fetchFromGitHub {
    owner = "lpenz";
    repo = "ogle";
    rev = "v2.0.2";
    sha256 = "0h65rprq0iaw6lrqycqza3nxmhgd3q2ipqh1jwbvrjmb0smiwccm";
  };
  cargoHash = "sha256-GC2kwYJ5GkL4oEP02wwgSSoy5M8bm3MMQyIic+yZR5w=";
}
