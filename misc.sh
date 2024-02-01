#!/bin/sh

set -euxo pipefail

nixos-rebuild --flake .#misc --target-host root@201:54fa:d57c:eb9a:16b4:9ea7:7fa6:7a82 switch
