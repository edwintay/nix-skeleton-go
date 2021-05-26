{
  sources ? import ./nix/sources.nix
}:

let
  gomod2nixOverlay = import (sources.gomod2nix + "/overlay.nix");
  pkgs = import sources.nixpkgs {
    overlays = [
      gomod2nixOverlay
    ];
  };
in

pkgs.mkShell {
  nativeBuildInputs = [
    pkgs.bashInteractive

    # build tools
    pkgs.go
    pkgs.gomod2nix

    # dev tools
    pkgs.golint
  ];

  shellHook = ''
    set -v

    export GOPATH="$(pwd)/.go"
    export GOCACHE=""
    export GO111MODULE='on'

    set +v
  '';

}
