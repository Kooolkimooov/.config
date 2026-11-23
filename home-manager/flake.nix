{
  description = "Home Manager for martin (Ubuntu, non-NixOS)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Caelestia, pinned to the exact commits that were in `nix profile`
    # (~/migration/2604-state/nix-profile.json). No "follows", so the builds stay
    # identical to what you run now.
    caelestia-shell.url = "github:Kooolkimooov/shell/7c063836ddbb3e8d971a02db3a7e6ca04aecb69f";
    caelestia-cli.url = "github:caelestia-dots/cli/68d1c64144c6552d4906030b5eef7a099b0c84fd";
  };
  
  outputs = inputs@{ nixpkgs, home-manager, ... }:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        # Non-free packages allowed by name. Only the NVIDIA driver libraries for now.
        config.allowUnfreePredicate = pkg:
          builtins.elem (nixpkgs.lib.getName pkg) [ "nvidia-x11" ];
        config.nvidia.acceptLicense = true;
      };
    in
    {
      homeConfigurations.martin = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; };
        modules = [ ./home.nix ];
      };
    };
}
