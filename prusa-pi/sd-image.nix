{ modulesPath, pkgs, config, lib, ... }:

{
  nixpkgs.hostPlatform = lib.systems.elaborate lib.systems.examples.raspberryPi;

  imports = [
    "${modulesPath}/profiles/base.nix"
    "${modulesPath}/installer/sd-card/sd-image.nix"
  ];

  environment.systemPackages = with pkgs; [
    libraspberrypi
    libgpiod gpio-utils
    i2c-tools
    screen
    vim
    git
    bottom
    (python39.withPackages(ps: with ps;[
      adafruit-pureio
      pyserial
    ]))
  ];

  networking.wireless.enable = true;

  boot = {
    loader.raspberryPi.firmwareConfig = ''
      dtparam=i2c=on
    '';
    kernelModules = [
      "i2c-dev"
    ];
  };
  hardware.i2c.enable = true;

  users = {
    extraGroups = {
      gpio = {};
    };
    extraUsers.pi = {
      isNormalUser = true;
      initialPassword = "raspberry";
      extraGroups = [ "wheel" "networkmanager" "dialout" "gpio" "i2c" ];
    };
  };
  services.getty.autologinUser = "pi";

  services.openssh = {
    enable = true;
    passwordAuthentication = true;
  };

  services.udev = {
    extraRules = ''
      KERNEL=="gpiochip0*", GROUP="gpio", MODE="0660"
    '';
  };
}
