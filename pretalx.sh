#!/bin/sh

set -euxo pipefail

nixos-rebuild --use-substitutes --flake .#pretalx --target-host root@202:4dc5:1dcd:7e7d:d76b:7453:c4a:d187 switch

