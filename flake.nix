{
  description = "Flake to test npm";

  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-22.05;
  inputs.flake-utils.url = "github:numtide/flake-utils";
  
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let 
        pkgs = import nixpkgs { 
          inherit system;
        };
      in rec {
        # configure the dev shell
        devShell = (
          pkgs.mkShell.override { stdenv = pkgs.clangStdenv; }
        ) {
          buildInputs = [ pkgs.bash pkgs.nodePackages.npm ];
        };
      }
    );
}
