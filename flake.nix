{
  description = "r3 iot vm config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # TODO: Add any other flake you might need
    hardware.url = "github:nixos/nixos-hardware";

    grical-to-mob.url = "github:realraum/grical-to-mobilizon";
    grical-to-mob.inputs.nixpkgs.follows = "nixpkgs";

    deckenlichtschalter.url = "github:realraum/deckenlichtschalter";
    deckenlichtschalter.inputs.nixpkgs.follows = "nixpkgs";

    mkg-mod.url = "github:mkg20001/mkg-mod/master";
    mkg-mod.inputs.nixpkgs.follows = "nixpkgs";

    # Shameless plug: looking for a way to nixify your themes and make
    # everything match nicely? Try nix-colors!
    # nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = {
    self,
    nixpkgs,
    grical-to-mob,
    mkg-mod,
    deckenlichtschalter,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      iot = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        # > Our main nixos configuration file <
        modules = [./iot/configuration.nix];
      };

      misc = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        # > Our main nixos configuration file <
        modules = [
          ({ nixpkgs.overlays = [ grical-to-mob.overlays.default ]; })
          mkg-mod.nixosModules.yggdrasil
          grical-to-mob.nixosModules.grical-to-mob
          ./misc/configuration.nix
        ];
      };

      hardlight = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        # > Our main nixos configuration file <
        modules = [
          ({ nixpkgs.overlays = [ deckenlichtschalter.overlays.default ]; })
          mkg-mod.nixosModules.yggdrasil
          deckenlichtschalter.nixosModules.golightctrl
          ./hardlight/configuration.nix
        ];
      };

      virt = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        # > Our main nixos configuration file <
        modules = [
          mkg-mod.nixosModules.yggdrasil
          ./virt/configuration.nix
        ];
      };

      acme = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        # > Our main nixos configuration file <
        modules = [
          mkg-mod.nixosModules.yggdrasil
          ./acme/configuration.nix
        ];
      };

      website = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        # > Our main nixos configuration file <
        modules = [
          mkg-mod.nixosModules.yggdrasil
          ./website/configuration.nix
        ];
      };

      prusa-pi = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        # > Our main nixos configuration file <
        modules = [./prusa-pi/configuration.nix];
      };
    };
  };
}
