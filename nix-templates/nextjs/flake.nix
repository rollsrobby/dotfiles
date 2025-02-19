{
  description = "Turborepo flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        devShell = pkgs.mkShell {
          buildInputs = [
            pkgs.nodejs_22
            pkgs.pnpm
            pkgs.turbo
            pkgs.docker
            pkgs.docker-buildx
            pkgs.biome
            pkgs.tailwindcss-language-server
            pkgs.typescript
            pkgs.typescript-language-server
            pkgs.vscode-langservers-extracted
          ];

          shellHook = ''
            echo "Welcome to the development shell"
          '';
        };
      in
      {
        devShells = {
          default = devShell;
        };
      }
    );
}

