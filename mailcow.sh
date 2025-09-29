#!/bin/sh

set -euxo pipefail

nixos-rebuild --use-substitutes --flake .#mailcow --target-host root@1.1.1.1 switch

