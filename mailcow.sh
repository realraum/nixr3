#!/bin/sh

set -euxo pipefail

nixos-rebuild --use-substitutes --flake .#pretalx --target-host root@1.1.1.1 switch

