# https://github.com/justinwoo/easy-purescript-nix/blob/7255d015b80d28c7c6db655dda215535cb2d4b41/psc-package2nix.nix

{ pkgs ? import <nixpkgs> {} }:

let
  # note that we have a SHA for the GitHub fetch result,
  # which is the result of cloning the repo at the given rev (and deleting .git)
  # see README
  repo = pkgs.fetchFromGitHub {
    owner = "purescript";
    repo = "package-sets";
    rev = "7755ff94d5efb45abea36f4903c6300ab908da6c";
    sha256 = "12zmyj5yyffz57vh1hxld7yp2l0j8qkqlkq49909mzgkq58q3m49";
  };

  myDerivation = pkgs.stdenv.mkDerivation rec {
    name = "my-derivation";

    src = repo;

    phases = "buildPhase";

    buildPhase = ''
      mkdir $out
      >$out/output echo "I am a build phase using ${src.outPath}."
    '';
  };

in {
  inherit repo;

  inherit myDerivation;
}
