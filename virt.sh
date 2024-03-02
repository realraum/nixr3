#!/bin/sh

set -euxo pipefail

nixos-rebuild --use-substitutes --flake .#virt --target-host root@r3virt.y.mkg20001.io switch
