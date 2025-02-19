{
  description = "Development shell for .NET Azure Function v4";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
  let
    system = "aarch64-darwin";
    pkgs = import nixpkgs { inherit system; };
  in {
  devShells.${system}.default = 
        pkgs.mkShell {
          buildInputs = [
            (with pkgs.dotnetCorePackages;
             combinePackages [
               sdk_8_0
               sdk_9_0
             ])
            pkgs.azure-functions-core-tools
            pkgs.dotnet-outdated
            pkgs.roslyn-ls
            pkgs.azurite
            pkgs.netcoredbg
          ];
          shellHook = ''
            export DOTNET_ROOT=${pkgs.dotnetCorePackages.sdk_9_0}
          '';
          permittedInsecurePackages = [
            "dotnet-sdk-6.0.428"
          ];
        };
  };
}
