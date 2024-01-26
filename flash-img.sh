#!/bin/bash

set -euxo pipefail
r=$(echo result/sd-image/*zst)
echo "flashing $r to $1. press return to start."
read noop
zstd -d "$r" -o /dev/stdout | sudo dd if=/dev/stdin "of=$1" oflag=direct bs=6M
