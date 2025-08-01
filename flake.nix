{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    helix.url = "github:/helix-editor/helix/master";
    #nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    #wezterm.url = "github:wezterm/wezterm/main";
    #nushell.url = "github:nushell/nushell/0.103.0";
    #nushell = {
    #  url = "github:nushell/nushell";
    #  ref = "c98642647878b4f66fb7e38388a3973071b0e27b";
    #};
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, ... }: {
    
    darwinConfigurations."Camerons-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/macbook/configuration.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.cameron = ./hosts/macbook/home.nix;
        }
      ];
    };
    
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/nixos-server/configuration.nix

          # make home-manager as a module of nixos
          # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.cameron = import ./hosts/nixos-server/home.nix;
            # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
          }
        ];
      };
    };   
  };
}
