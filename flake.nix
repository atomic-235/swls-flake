{
  description = "Semantic Web Language Server, packaged from upstream release binaries";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs, ... }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        rec {
          default = pkgs.callPackage ./package.nix { };
          swls = default;
        }
      );

      overlays.default = final: _prev: {
        swls = final.callPackage ./package.nix { };
      };
    };
}
