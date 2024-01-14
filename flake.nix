{
  description = "Personal NixOS configuration";
  inputs = {
    nixpkgs.url = "flake:nixpkgs/nixpkgs-unstable";
    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, nixos-generators, nixpkgs, ... }@inputs:
    let
      hokanosekai = import ./loader/from_envs.nix;
      flakeContext = {
        inherit inputs;
        inherit hokanosekai;
      };
    in
    {
      nixosModules = {
        system = import ./nixosModules/system.nix flakeContext;
        user-root = import ./nixosModules/user-root.nix flakeContext;
        services = import ./nixosModules/services.nix flakeContext;
      };
      packages = {
        x86_64-linux = {
          nixos = import ./packages/nixos.nix flakeContext;
        };
      };
    };
}
