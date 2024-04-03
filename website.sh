#!/bin/sh

set -euxo pipefail

nixos-rebuild --use-substitutes --flake .#website --target-host root@200:1dc9:1d41:a40b:a972:b00f:dfa0:db09 switch
