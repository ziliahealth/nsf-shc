{}:
let
  nixpkgs = rec {
    rev = "030ba1976b7c0e1a67d9716b17308ccdab5b381e"; # 24.11 - 2025-02-04
    sha256 = "14rpk53mia7j0hr4yaf5m3b2d4lzjx8qi2rszxjhqq00pxzzr64w";
    url = "https://github.com/NixOS/nixpkgs/archive/${rev}.tar.gz";
    src = builtins.fetchTarball {
      inherit url;
      inherit sha256;
    };
  };
in
import nixpkgs.src {
  overlays = [ ];
  config = {
    allowUnfree = true;
  };
}
