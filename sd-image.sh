#!/bin/bash

set -euxo pipefail

nix build ".#nixosConfigurations.$1.config.system.build.sdImage" -L

