{ pkgs ? (import ./.nix/pinned-nixpkgs.nix { }) }:

let
  nix-lib = pkgs.callPackage ./nix-lib { };
in

{
  inherit nix-lib;
}
