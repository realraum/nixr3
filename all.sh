#!/bin/bash

set -euxo pipefail

for m in virt misc website; do
  bash "$m.sh"
done
