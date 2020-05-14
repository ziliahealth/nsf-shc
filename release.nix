{ pkgs ? import <nixpkgs> {} }:

let
  nix-lib = pkgs.callPackage ./nix-lib {};
in

{
  inherit nix-lib;
}
