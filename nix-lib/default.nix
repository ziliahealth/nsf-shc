{ lib
, bash-completion
} @ args:

let
  callPackage = lib.callPackageWith args;
in

rec {
  nsfShC = {
    env = callPackage ./env.nix {};
    pkg = callPackage ./pkg.nix {};
    shell = callPackage ./shell.nix {};
  };

  # Deprecated. Backward comp.
  # TODO: Remove at some point.
  shComp = nsfShC;
}
