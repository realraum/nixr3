#!/bin/sh

set -euxo pipefail

nixos-rebuild --use-substitutes --flake .#party --target-host root@lol switch

