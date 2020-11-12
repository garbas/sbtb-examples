{ pkgs_ ? import <nixpkgs> {}
}:
let
  sbt-derivation = pkgs_.fetchFromGitHub {
    owner = "zaninime";
    repo = "sbt-derivation";
    rev = "9666b2b589ed68823fff1cefa4cd8a8ab54956c1";
    sha256 = "0000000000000000000000000000000000000000000000000000";
  };
  jdk = pkgs.openjdk_headless;
  mainClass = "CubeCalculator.App";
  pkgs = import <nixpkgs> { overlays = [ (import sbt-derivation) ]; };
in pkgs.sbt.mkDerivation rec {
  pname = "sbt-nix-example";
  version = "1.0.0";
  depsSha256 = "0000000000000000000000000000000000000000000000000000";
  depsWarmupCommand = ''
    sbt compile
  '';
  nativeBuildInputs = [ pkgs.makeWrapper ];
  src = pkgs.lib.sourceByRegex ./. [
    "^project\$"
    "^project/.*\$"
    "^src\$"
    "^src/.*\$"
    "^build.sbt\$"
  ];
  buildPhase = ''
    sbt stage
  '';
  installPhase = ''
    mkdir -p \$out/{bin,lib}
    cp -ar target/universal/stage/lib \$out/lib/\${pname}
    makeWrapper \${jdk}/bin/java \$out/bin/\${pname} \
      --add-flags "-cp '\$out/lib/\${pname}/*' \${pkgs.lib.escapeShellArg mainClass}"
  '';
}