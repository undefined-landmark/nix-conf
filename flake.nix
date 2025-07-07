{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    qbit.url = "github:undefined-landmark/nixpkgs/default-serverConfig";
    omnissa.url = "github:mhutter/nixpkgs/bump/horizon-client";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    my-secrets = {
      url = "git+file:///home/bas/git/nix-secrets";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    pkgsOmnissa = import inputs.omnissa {
      system = "x86_64-linux";
      config = {
        allowUnfree = true;
        permittedInsecurePackages = ["libxml2-2.13.8"];
      };
    };
  in {
    nixosConfigurations = {
      ecobox = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [./hosts/ecobox/configuration.nix];
      };
      lightbox = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs pkgsOmnissa;};
        modules = [./hosts/lightbox/configuration.nix];
      };
      bigbox = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [./hosts/bigbox/configuration.nix];
      };
    };
  };
}
