{
  description = "da-desktop";

  inputs = {
    # Nix package sources
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hardware support
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    # NUR (Nix User Repository)
    nur.url = "github:nix-community/NUR";

    # Pre-commit hooks
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";

    # Neovim flake
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    nixos-hardware,
    nur,
    pre-commit-hooks,
    flake-utils,
    nvf,
    ...
  }: let
    # Define system architecture (default to x86_64-linux)
    system = "x86_64-linux";

    # Helper function to generate a package set with overlays
    pkgsFor = system: import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [
        (final: prev: {
          stable = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
        })
        nur.overlay
      ];
    };

    # Shared arguments to pass to modules
    specialArgs = {
      inherit inputs system;
    };
  in {
    # Define a single NixOS system configuration
    nixosConfigurations = {
      da-desktop = nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        modules = [
          ./configuration.nix
          nvf.nixosModules.default
        ];
      };
    };

    # Define development shells
    devShells = flake-utils.lib.eachDefaultSystem (system: let
      pkgs = pkgsFor system;
    in {
      default = pkgs.mkShell {
        packages = with pkgs; [
          nixpkgs-fmt
          nil
          git
          python3
          nodejs
          rustc
          cargo
        ];
      };
    });

    # Pre-commit hooks
    checks = flake-utils.lib.eachDefaultSystem (system: {
      pre-commit-check = pre-commit-hooks.lib.${system}.run {
        src = ./.;
        hooks = {
          nixpkgs-fmt.enable = true;
          statix.enable = true;
          deadnix.enable = true;
        };
      };
    });

    # Formatter
    formatter = flake-utils.lib.eachDefaultSystem (system: (pkgsFor system).nixpkgs-fmt);
  };
}
