#!/bin/sh

set -euxo pipefail

nixos-rebuild --flake .#virt --target-host root@192.168.69.132 switch
