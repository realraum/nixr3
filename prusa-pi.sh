#!/bin/sh

set -euxo pipefail

nixos-rebuild --flake .#prusa-pi --build-host $(id -un)@aarch64.mkg20001.io --target-host root@prusa-pi switch
