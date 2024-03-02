#!/bin/sh

set -euxo pipefail

nixos-rebuild --use-substitutes --flake .#misc --target-host root@204:bc6d:6fd3:981a:dbcd:9e8a:52ae:a029 switch
