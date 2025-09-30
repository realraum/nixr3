#!/bin/sh

set -euxo pipefail

nixos-rebuild --use-substitutes --flake .#mailcow --target-host root@mailcow.realraum.at switch

