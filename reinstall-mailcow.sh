#!/bin/sh

nix run github:nix-community/nixos-anywhere -- --flake '.#mailcow' root@$1

