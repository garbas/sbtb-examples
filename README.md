# Nix throught examples

TODO: what is this document about

 for Scale by The Bay

**Content:**

- [1. Why Nix?](#1-why-nix)
- [2. Developmnent shell](#2-developmnent-shell)
- [3. Declarative development environment](#3-declarative-development-environment)
- [4. Reproducible CI](#4-reproducible-ci)
- [5. Better docker images](#5-better-docker-images)
- [6. Sbt + Nix](#6-sbt--nix)


[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/garbas/sbtb-examples)

## 1. Why Nix?

[Why Nix?](https://5fad2bd6b3d38100bedd3ba8--nixos-homepage.netlify.app/overview.html)

## 2. Install Nix

```
$ curl -L https://nixos.org/nix/install | sh
```

## 2. Developmnent shell

$ nix-shell -p scala sbt

## 3. Declarative development environment

$ cat shell.nix
{ pkgs ? import <nixpkgs> {}
}:
pkgs.mkShell {
    buildInputs =
      [ pkgs.scala
        pkgs.sbt
      ];
}
$ nix-shell
$ nix-shell --command "scala"

## 4. Reproducible CI

nix-shell --command "sbt clean compile test"

## 5. Better docker images

$ cat docker.nix
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

## 6. Sbt + Nix

$ cat default.nix