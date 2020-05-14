{ lib
, bash-completion
} @ args:

let
  callPackage = lib.callPackageWith args;
in

{
  shComp = {
    env = callPackage ./env.nix {};
    pkg = callPackage ./pkg.nix {};
  };
}
