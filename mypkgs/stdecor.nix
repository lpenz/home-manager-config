{ pkgs }:
pkgs.rustPlatform.buildRustPackage rec {
  pname = "stdecor";
  version = "0.1.14";
  src = pkgs.fetchFromGitHub {
    owner = "lpenz";
    repo = "stdecor";
    rev = "v0.1.14";
    sha256 = "06m6bkq5vggmyjl9rxcm3ygwcvyx21dggn7pfcvd0q4wyvnrrlpq";
  };
  cargoHash = "sha256-srvdBUA4Omw4nnrofxnBNWPI/0KKz5J/efARIOYrai0=";
}
