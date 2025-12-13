#!/bin/sh

set -euxo pipefail

nixos-rebuild --use-substitutes --flake .#party --target-host root@202:fd50:7d13:b44:f2b0:2cec:1a8d:ded4 switch

