{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  buildInputs = [
    pkgs.openmpi
    pkgs.clang_14
  ];
}