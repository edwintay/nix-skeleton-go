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
  gitignorePkg = import sources."gitignore.nix" { inherit (pkgs) lib; };
  inherit (gitignorePkg) gitignoreSource;
in

pkgs.buildGoApplication {
  pname = "nix-skeleton-go";
  version = "0.0.1";
  src = gitignoreSource ./.;
  modules = ./gomod2nix.toml;
}
