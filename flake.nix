{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    prom-qbit.url = "github:undefined-landmark/nixpkgs/qbit-exp-module";
    qui.url = "github:undefined-landmark/nixpkgs/qui-service";

    my-secrets = {
      url = "git+file:///home/bas/git/nix-secrets";
      inputs.nixpkgs.follows = "unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    let
      pkgsUnstable = import inputs.unstable {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations = {
        ecobox = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs pkgsUnstable; };
          modules = [ ./hosts/ecobox/configuration.nix ];
        };
        lightbox = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs pkgsUnstable; };
          modules = [ ./hosts/lightbox/configuration.nix ];
        };
        bigbox = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs pkgsUnstable; };
          modules = [ ./hosts/bigbox/configuration.nix ];
        };
        tinybox = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs pkgsUnstable; };
          modules = [ ./hosts/tinybox/configuration.nix ];
        };
      };
    };
}
