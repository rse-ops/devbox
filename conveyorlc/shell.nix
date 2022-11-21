{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  buildInputs = [
    pkgs.openmpi
    pkgs.boost172
    pkgs.openbabel
    pkgs.python3
  ];
}
