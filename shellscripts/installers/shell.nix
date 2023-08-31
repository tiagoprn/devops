{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    zlib.dev
    openssl.dev
    readline.dev
    sqlite.dev
    bzip2.dev
    libffi.dev
  ];
}

