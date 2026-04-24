{
    description = "my system :3";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        sops-nix = {
            url = "github:Mic92/sops-nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager, sops-nix, ... }@inputs:
    let
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
        myNeovimThing = pkgs.callPackage ./modules/nvim.nix {};
    in {
        packages.${system}.dev-container = import ./modules/webssh-image.nix {
            inherit pkgs;
            nvim = myNeovimThing;
        };

        nixosConfigurations.deathstar = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = {
                inherit inputs;
                myNeovim = myNeovimThing;
            };
            modules = [
                ./configuration.nix
                home-manager.nixosModules.home-manager {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.users.shin = import ./users/shin/home.nix;
                }
                sops-nix.nixosModules.sops
            ];
        };
    };
}
