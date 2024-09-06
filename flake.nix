{
  description = "Tools for managing the static-site";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem(system: let
      pkgs = nixpkgs.legacyPackages.${system};
      nodejs = pkgs.nodejs_20;
    in {
      devShells.default = pkgs.mkShell {
        packages = [ nodejs ];
        shellHook = ''
          export NO_UPDATE_NOTIFIER=1
          npm i
        '';
      };

      packages.default = pkgs.buildNpmPackage {
        name = "littlebiglogic";
        src = ./.;
        npmDepsHash = "sha256-g48xblHNi28hLdQVhSjW4r8Vp9e3KuEBRVZKgXzFC0Y=";
        inherit nodejs;
        installPhase = "mv dist $out";
      };

      hydraJobs.build = self.packages.${system}.default;
    });
}
