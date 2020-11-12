{ pkgs ? import <nixpkgs> {}
}:
pkgs.dockerTools.buildLayeredImage {
    name = "nix-scala";
    tag = "latest";
    contents =
      [ pkgs.scala
        pkgs.sbt
      ];
}