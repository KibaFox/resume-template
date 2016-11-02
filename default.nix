let
  pkgs = import <nixpkgs> {};
in
  pkgs.stdenv.mkDerivation {
    name = "Resume";
    src = ./.;
    buildInputs = [
      pkgs.gnumake
      pkgs.pandoc
      pkgs.python35
      pkgs.rsync
      pkgs.wkhtmltopdf
    ];
  }
