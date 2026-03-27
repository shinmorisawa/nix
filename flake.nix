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

  outputs = { self, nixpkgs, home-manager, sops-nix, ... }@inputs: {
      nixosConfigurations.deathstar = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
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
