{ pkgs ? import <nixpkgs> {}
}:
pkgs.mkShell {
    buildInputs =
      [ pkgs.scala
        pkgs.sbt
      ];
}
