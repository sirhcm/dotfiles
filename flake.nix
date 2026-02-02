{
  description = "portable dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    handarbeit-vim = {
      url = "github:sirhcm/handarbeit.vim";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in {
      homeConfigurations = forAllSystems (system:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          extraSpecialArgs = { inherit inputs; };
          modules = [ ./home.nix ];
        }
      );

      apps = forAllSystems (system: {
        default = {
          type = "app";
          program = "${self.homeConfigurations.${system}.activationPackage}/activate";
        };
      });
    };
}
