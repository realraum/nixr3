#!/bin/sh

set -euxo pipefail

nixos-rebuild --flake .#misc --build-host $(id -un)@aarch64.mkg20001.io --target-host root@200:14ca:b701:a36e:7bd4:e4df:c578:7e10 switch
