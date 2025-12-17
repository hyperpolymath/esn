# SPDX-License-Identifier: AGPL-3.0-or-later
# SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
#
# flake.nix — Nix flake for esn (fallback package manager)
# Reference: https://nixos.wiki/wiki/Flakes

{
  description = "Echo State Network - Reservoir Computing library in Rust";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, rust-overlay, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs {
          inherit system overlays;
        };
        rustToolchain = pkgs.rust-bin.stable.latest.default.override {
          extensions = [ "rust-src" "rust-analyzer" "clippy" "rustfmt" ];
        };
      in
      {
        # Development shell: nix develop
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            rustToolchain
            cargo-audit
            cargo-outdated
            cargo-tarpaulin
            pkg-config
            openssl
          ];

          shellHook = ''
            echo "ESN development shell"
            echo "Rust version: $(rustc --version)"
            echo ""
            echo "Available commands:"
            echo "  cargo build    - Build the project"
            echo "  cargo test     - Run tests"
            echo "  cargo audit    - Security audit"
            echo "  cargo clippy   - Lint check"
          '';
        };

        # Package: nix build
        packages.default = pkgs.rustPlatform.buildRustPackage {
          pname = "esn";
          version = "0.1.0";
          src = ./.;
          cargoLock.lockFile = ./Cargo.lock;

          meta = with pkgs.lib; {
            description = "Echo State Network - Reservoir Computing library in Rust";
            homepage = "https://github.com/hyperpolymath/esn";
            license = with licenses; [ mit agpl3Plus ];
            maintainers = [ ];
          };
        };

        # Check: nix flake check
        checks.default = self.packages.${system}.default;
      });
}
