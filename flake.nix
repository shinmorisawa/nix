{
  description = "my system :3";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
      nixosConfigurations.deathstar = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
              ./configuration.nix
              ./hardware-configuration.nix
          ];
      };
  };
}
