#!/bin/sh

set -euxo pipefail

nixos-rebuild --flake .#misc --build-host $(id -un)@aarch64.mkg20001.io --target-host root@r3-misc switch
