#!/bin/sh

set -euxo pipefail

nixos-rebuild --use-substitutes --flake .#acme --target-host root@r3acme.y.mkg20001.io switch
