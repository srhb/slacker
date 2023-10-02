{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.flake-parts.url = "github:hercules-ci/flake-parts";

  description = "Slacker";

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];
      imports = [ ];
      perSystem = {
        inputs',
        self',
        pkgs,
        ...
      }: {
        packages.default = pkgs.haskell.packages.ghc94.callCabal2nix "slacker" ./. {};
        devShells.default = pkgs.mkShell {
          inputsFrom = [self'.packages.default];
          packages = with pkgs.haskell.packages.ghc94; [
            haskell-language-server
            cabal-install
          ];
        };
      };
    };
}
