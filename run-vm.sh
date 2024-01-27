#!/bin/sh

set -euo pipefail

TARGET="$1"
R="result-$TARGET"
nix build ".#nixosConfigurations.$TARGET.config.system.build.vm" -o "$R"
./$R/bin/run-*-vm
