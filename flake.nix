{
  description = "this flake sucks lol";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-doom-emacs-unstraightened = {
      url = "github:marienz/nix-doom-emacs-unstraightened";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    claude-code.url = "github:sadjow/claude-code-nix";
    opencode.url = "github:anomalyco/opencode";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nixvim,
      noctalia,
      spicetify-nix,
      nix-doom-emacs-unstraightened,
      rust-overlay,
      ...
    }@inputs:
    let
      mkHomeManager = username: {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit inputs; };
        home-manager.users."${username}" = {
          imports = [
            nixvim.homeModules.nixvim
            noctalia.homeModules.default
            spicetify-nix.homeManagerModules.spicetify
            nix-doom-emacs-unstraightened.homeModule
            ./modules/home.nix
          ];
        };
        nixpkgs.overlays = [ rust-overlay.overlays.default ];
      };
    in
    {
      nixosConfigurations.lain = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/lain/configuration.nix
          home-manager.nixosModules.home-manager
          (mkHomeManager "matheus")
        ];
      };

      nixosConfigurations.kaori = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/kaori/configuration.nix
          home-manager.nixosModules.home-manager
          (mkHomeManager "matheus")
        ];
      };
    };
}
