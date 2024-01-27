#!/bin/sh

set -euxo pipefail

nixos-rebuild --flake .#misc --build-host $(id -un)@aarch64.mkg20001.io --target-host root@200:37be:29a6:3dea:9366:5bb:773c:9109 switch
