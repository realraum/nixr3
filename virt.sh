#!/bin/sh

set -euxo pipefail

nixos-rebuild --use-substitutes --flake .#virt --target-host root@r3virt.realraum.at switch
