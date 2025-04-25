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
  cargoHash = "sha256-Hlxe/5qchwyJ/cYqWIvIkHswJW3TTt/4WmLzIEY4Gy8=";
}
